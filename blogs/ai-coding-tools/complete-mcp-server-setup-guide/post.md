# The Complete MCP Server Setup Guide: Claude Desktop, Claude Code, and Cursor

*Stop wasting time with broken configs. Here's the setup that actually works.*

## Why This Guide Exists

You've probably stumbled across 5 different blog posts about MCP (Model Context Protocol) servers, tried 3 different configs, and ended up with nothing working. The documentation is scattered, package names are wrong in popular guides, and nobody tells you which config file goes where.

This guide fixes that. One comprehensive walkthrough for all three tools.

## ⚠️ CRITICAL: Replace Usernames and Paths

**Before you start**: This guide contains placeholder usernames and paths that you MUST replace with your actual system information:

- **`YOUR_USERNAME`** → Replace with your actual username (e.g., `john`, `mary`, `swami`)
- **`/path/to/allowed/directory`** → Replace with actual directory paths you want to grant access to
- **`/Users/YOUR_USERNAME/`** → Replace with your actual home directory path

**How to find your username:**
- **macOS/Linux**: Run `whoami` in terminal or `echo $USER`
- **Windows**: Run `echo %USERNAME%` in Command Prompt or `$env:USERNAME` in PowerShell

**How to find your home directory:**
- **macOS**: `/Users/YOUR_USERNAME`
- **Linux**: `/home/YOUR_USERNAME` 
- **Windows**: `C:\Users\YOUR_USERNAME`

**Example transformation:**
```json
// ❌ WRONG - Contains placeholder
"/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"

// ✅ CORRECT - Uses actual username
"/Users/swami/claude-mcp-configs/shared-memory.json"
```

## Quick Reference: Which Tool When?

Before we dive into setup, understand what you're installing:

| Tool | Best For | Interface | Config Location |
|------|----------|-----------|-----------------|
| **Claude Desktop** | GUI workflows, exploring projects | Desktop app | `~/Library/Application Support/Claude/claude_desktop_config.json` (Mac) |
| **Claude Code** | Terminal workflows, CI/CD, scripting | CLI | `~/.claude.json` |
| **Cursor IDE** | Full IDE experience, VS Code users | Desktop IDE | `.cursor/config.json` (project) or global settings |

**Architecture**

To illustrate how shared-memory works between the different tools that can access MCP servers:

```
┌─────────────────┐
│ Claude Desktop  │──┐
└─────────────────┘  │
                     │    ┌──────────────────┐
┌─────────────────┐  ├───▶│ Memory MCP Server│
│  Claude Code    │──┤    │  (shared file)   │
└─────────────────┘  │    └──────────────────┘
                     │
┌─────────────────┐  │
│   Cursor IDE    │──┘
└─────────────────┘
```

**Key Insight**: You can run all three and share the same MCP servers!

---

## Part 1: Foundation Setup

### Prerequisites

<details>
<summary><strong>Platform-Specific Installation Instructions</strong></summary>

**All Operating Systems:**
```bash
# Verify Node.js (v16+ required)
node --version

# Verify npm
npm --version

# Install Claude Code CLI (if needed)
npm install -g @anthropic-ai/claude-code
```

**macOS-specific:**
```bash
# Install Node.js via Homebrew (recommended)
brew install node
```

**Windows-specific:**
- Download Node.js installer from [nodejs.org](https://nodejs.org)
- Or use Chocolatey: `choco install nodejs`
- Or use winget: `winget install OpenJS.NodeJS`

**Linux-specific:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nodejs npm

# Fedora/RHEL
sudo dnf install nodejs npm

# Arch
sudo pacman -S nodejs npm
```

</details>

### Critical Package Name Correction

**STOP**: Many guides (including QED42's popular post) use wrong package names.

❌ **WRONG**: `@mcp-plugins/memory`  
✅ **CORRECT**: `@modelcontextprotocol/server-memory`

❌ **WRONG**: `@mcp-plugins/file-system`  
✅ **CORRECT**: `@modelcontextprotocol/server-filesystem`

This error alone causes 80% of failed installations.

---

## Part 2: Complete Setup by Product

Choose your tool and follow the complete setup in one place:

---

### 2.1: 🖥️ Claude Desktop - Complete Setup

#### Installation

**macOS:**
- Download from [claude.ai](https://claude.ai)
- Or install via Homebrew: `brew install --cask claude`

**Windows:**
- Download from [claude.ai](https://claude.ai)
- Run the installer

**Linux:**
- AppImage available from [claude.ai](https://claude.ai)

#### Configuration File Location

| OS | Config Path |
|----|-------------|
| **macOS** | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| **Windows** | `%APPDATA%\Claude\claude_desktop_config.json` |
| **Linux** | `~/.config/Claude/claude_desktop_config.json` |

#### Finding the Config Folder via Claude Desktop UI

**macOS:**
1. Open Claude Desktop
2. Click the **Claude** menu in the menu bar (top-left)
3. Select **Preferences** (or press `Cmd + ,`)
4. In the Preferences window, look for **Advanced** or **Developer** settings
5. You'll see the config file path displayed, or click **"Open Config Folder"** if available

**Windows:**
1. Open Claude Desktop
2. Click the **three-dot menu** (⋮) in the top-right corner
3. Select **Settings** (or press `Ctrl + ,`)
4. Navigate to **Advanced** or **Developer** section
5. The config file path will be shown, or click **"Open Config Folder"** if available

**Linux:**
1. Open Claude Desktop
2. Click the **hamburger menu** (☰) or **Settings** icon
3. Select **Preferences** or **Settings**
4. Look for **Advanced** or **Developer** options
5. The config file path will be displayed

**Alternative method (all platforms):**
- Right-click on the Claude Desktop icon in your system tray/taskbar
- Look for **"Open Config Folder"** or **"Settings"** option

#### Initial Setup

**macOS:**
```bash
# Create directory if it doesn't exist
mkdir -p ~/Library/Application\ Support/Claude

# Create config file
touch ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Edit with your preferred editor
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

**Windows (PowerShell):**
```powershell
# Create directory if it doesn't exist
New-Item -Path $env:APPDATA\Claude -ItemType Directory -Force

# Create config file
New-Item -Path $env:APPDATA\Claude\claude_desktop_config.json -ItemType File -Force

# Edit
notepad $env:APPDATA\Claude\claude_desktop_config.json
```

**Linux:**
```bash
# Create directory if it doesn't exist
mkdir -p ~/.config/Claude

# Create config file
touch ~/.config/Claude/claude_desktop_config.json

# Edit
nano ~/.config/Claude/claude_desktop_config.json
```

#### Understanding Your Claude Desktop Config Structure

Before adding MCP servers, check what's already in your `claude_desktop_config.json`:

**Scenario 1: Empty or New Config File**
If your config is empty, create the entire structure:
```json
{
  "mcpServers": {
    // Your MCP server configurations go here
  }
}
```

**Scenario 2: Existing Config with Empty mcpServers**
Your config might look like this:
```json
{
  "mcpServers": {}
}
```

**Scenario 3: Existing Config with Populated mcpServers**
Your config might already have MCP servers:
```json
{
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"]
    }
  }
}
```

#### How to Locate and Edit the mcpServers Section in Claude Desktop

**Step 1: Open your config file**
```bash
# macOS
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Windows
notepad %APPDATA%\Claude\claude_desktop_config.json

# Linux
nano ~/.config/Claude/claude_desktop_config.json
```

**Step 2: Find the mcpServers section**
- Look for `"mcpServers":` in the file
- If it doesn't exist, you'll need to add it
- If it exists but is empty `{}`, you'll add servers inside the braces
- If it has existing servers, you'll add new ones alongside them

**Step 3: Add your MCP server configuration**
- **For empty config**: Add the entire structure (see examples below)
- **For existing config**: Add new servers inside the existing `mcpServers` object
- **Note**: Claude Desktop does NOT require `"type": "stdio"` (unlike Claude Code)

**Example: Adding to existing config with other servers**
```json
{
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"]
    },
    "new-memory-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

**Step 4: Validate your JSON**
```bash
# macOS/Linux
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool

# Windows (PowerShell)
Get-Content $env:APPDATA\Claude\claude_desktop_config.json | ConvertFrom-Json
```

<details>
<summary><strong>Option 1: Simple Setup (mcp-cursor - Recommended)</strong></summary>

**Best for**: Getting started quickly with filesystem, memory, and reasoning

```json
{
  "mcpServers": {
    "mcp-cursor": {
      "command": "npx",
      "args": ["-y", "mcp-cursor"]
    }
  }
}
```

**Install the server:**
```bash
npm install -g mcp-cursor
```

</details>

<details>
<summary><strong>Option 2: Shared Memory Setup</strong></summary>

**Best for**: Sharing context across Claude Desktop, Claude Code, and Cursor

**Step 1: Create shared memory file**

**macOS:**
```bash
mkdir -p ~/claude-mcp-configs
touch ~/claude-mcp-configs/shared-memory.json
```

**Windows (PowerShell):**
```powershell
New-Item -Path $env:USERPROFILE\claude-mcp-configs -ItemType Directory -Force
New-Item -Path $env:USERPROFILE\claude-mcp-configs\shared-memory.json -ItemType File -Force
```

**Linux:**
```bash
mkdir -p ~/claude-mcp-configs
touch ~/claude-mcp-configs/shared-memory.json
```

**Step 2: Install memory server**
```bash
npm install -g @modelcontextprotocol/server-memory
```

**Step 3: Add to config**

**macOS/Linux config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"
      ]
    }
  }
}
```

**Windows config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "C:\\Users\\YOUR_USERNAME\\claude-mcp-configs\\shared-memory.json"
      ]
    }
  }
}
```

**⚠️ CRITICAL**: Replace `YOUR_USERNAME` with your actual username. Use absolute paths only.

**Quick username lookup:**
```bash
# macOS/Linux
whoami
# or
echo $USER

# Windows (Command Prompt)
echo %USERNAME%

# Windows (PowerShell)
$env:USERNAME
```

**Example**: If your username is `john`, replace:
- `/Users/YOUR_USERNAME/` → `/Users/john/`
- `C:\\Users\\YOUR_USERNAME\\` → `C:\\Users\\john\\`

</details>

<details>
<summary><strong>Option 3: Advanced Setup (Multiple Servers)</strong></summary>

**Best for**: Power users who need specific capabilities

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/directory"
      ]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    }
  }
}
```

**Install servers:**
```bash
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking
```

</details>

#### Applying Changes

**Always restart Claude Desktop after editing the config:**

**macOS:**
```bash
# Quit completely
osascript -e 'quit app "Claude"'
# Then reopen from Applications
```

**Windows:**
- Right-click Claude in system tray → Exit
- Or use PowerShell: `Stop-Process -Name "Claude" -Force`
- Reopen from Start menu

**Linux:**
```bash
killall claude
# Then reopen
```

<details>
<summary><strong>Verification & Troubleshooting</strong></summary>

#### Step 1: Verify Config File Exists and is Valid

**Check if config file exists:**
```bash
# macOS
ls -la ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Windows (PowerShell)
Test-Path $env:APPDATA\Claude\claude_desktop_config.json

# Linux
ls -la ~/.config/Claude/claude_desktop_config.json
```

**Validate JSON syntax:**

**macOS/Linux:**
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool
```

**Windows (PowerShell):**
```powershell
Get-Content $env:APPDATA\Claude\claude_desktop_config.json | ConvertFrom-Json
```

#### Step 2: Verify MCP Servers are Running in Claude Desktop

**Visual verification in Claude Desktop:**
1. Open Claude Desktop application
2. Start a new conversation
3. Look for **MCP tools indicator** in the interface (usually shows as a small icon or badge)
4. Try asking: **"What MCP tools do you have access to?"**
5. The response should list your configured MCP servers

**Expected response example:**
```
I have access to the following MCP tools:
- Memory Server (for storing and retrieving information)
- Filesystem Server (for file operations)
- Sequential Thinking Server (for complex reasoning)
```

#### Step 3: Test MCP Functionality

**Test Memory Server:**
1. Ask: **"Remember that my favorite color is blue"**
2. Start a new conversation
3. Ask: **"What's my favorite color?"**
4. Should respond: **"Your favorite color is blue"**

**Test Filesystem Server (if configured):**
1. Ask: **"List the files in my Documents folder"**
2. Should show actual files from your Documents directory

#### Step 4: Check Logs for Errors

**macOS:**
```bash
tail -f ~/Library/Logs/Claude/mcp*.log
```

**Windows (PowerShell):**
```powershell
Get-Content $env:APPDATA\Claude\logs\mcp*.log -Tail 50
```

**Linux:**
```bash
tail -f ~/.config/Claude/logs/mcp*.log
```

**Look for:**
- ✅ **Success indicators**: "MCP server started", "Connected to server"
- ❌ **Error indicators**: "Failed to start", "Connection refused", "File not found"

#### Step 5: Troubleshooting Common Issues

**If MCP tools don't appear:**
1. Restart Claude Desktop completely
2. Check JSON syntax with validation commands above
3. Verify all file paths are correct (no `YOUR_USERNAME` placeholders)
4. Check logs for specific error messages

**If memory doesn't persist:**
1. Verify shared memory file path is correct
2. Check file permissions on the memory file
3. Ensure the same path is used across all tools

</details>

---

### 2.2: 💻 Claude Code (CLI) - Complete Setup

#### Installation

**All platforms:**
```bash
npm install -g @anthropic-ai/claude-code
```

**Verify installation:**
```bash
claude --version
```

#### Configuration File Location

| OS | Config Path |
|----|-------------|
| **macOS** | `~/.claude.json` |
| **Windows** | `%USERPROFILE%\.claude.json` |
| **Linux** | `~/.claude.json` |

#### Finding the Config File via Claude Code CLI

**Navigate to config file manually**
# User settings location varies by platform:
# macOS: ~/.claude/settings.json
# Linux: ~/.config/claude/settings.json
# Windows: %APPDATA%\claude\settings.json

-OR-

**Use keyboard shortcuts to locate them using the Finder**

**macOS:**
1. Open **Finder**
2. Press `Cmd + Shift + G` (Go to Folder)
3. Type: `~` and press Enter
4. Press `Cmd + Shift + .` to show hidden files
5. Look for `.claude.json`

**Windows:**
1. Open **File Explorer**
2. In the address bar, type: `%USERPROFILE%`
3. Press Enter
4. Press `Alt + T` → **Folder Options** → **View** tab
5. Check **"Show hidden files, folders, and drives"**
6. Look for `.claude.json`

**Linux:**
1. Open **File Manager** (Nautilus, Dolphin, etc.)
2. Press `Ctrl + H` to show hidden files
3. Navigate to your home directory
4. Look for `.claude.json`

#### Initial Setup

**macOS/Linux:**
```bash
# Create config file
touch ~/.claude.json

# Edit
nano ~/.claude.json
```

**Windows (PowerShell):**
```powershell
# Create config file
New-Item -Path $env:USERPROFILE\.claude.json -ItemType File -Force

# Edit
notepad $env:USERPROFILE\.claude.json
```

#### Understanding Your Config File Structure

Before adding MCP servers, you need to understand what's already in your config file. Here are the common scenarios:

**Scenario 1: Empty or New Config File**
If your `.claude.json` is empty or doesn't exist, you'll create the entire structure:

```json
{
  "mcpServers": {
    // Your MCP server configurations go here
  }
}
```

**Scenario 2: Existing Config with Empty mcpServers**
Your config might look like this:
```json
{
  "apiKey": "your-api-key-here",
  "mcpServers": {}
}
```

**Scenario 3: Existing Config with Populated mcpServers**
Your config might already have MCP servers:
```json
{
  "apiKey": "your-api-key-here",
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"],
      "type": "stdio"
    }
  }
}
```

#### How to Locate and Edit the mcpServers Section

**Step 1: Open your config file**
```bash
# macOS/Linux
nano ~/.claude.json
# or
code ~/.claude.json

# Windows
notepad %USERPROFILE%\.claude.json
# or
code %USERPROFILE%\.claude.json
```

**Step 2: Find the mcpServers section**
- Look for `"mcpServers":` in the file
- If it doesn't exist, you'll need to add it
- If it exists but is empty `{}`, you'll add servers inside the braces
- If it has existing servers, you'll add new ones alongside them

**Step 3: Add your MCP server configuration**
- **For empty config**: Add the entire structure (see examples below)
- **For existing config**: Add new servers inside the existing `mcpServers` object
- **Always ensure proper JSON syntax** with commas between multiple servers

**Example: Adding to existing config with other servers**
```json
{
  "apiKey": "your-api-key-here",
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"],
      "type": "stdio"
    },
    "new-memory-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "type": "stdio"
    }
  }
}
```

**Step 4: Validate your JSON**
```bash
# macOS/Linux
cat ~/.claude.json | python3 -m json.tool

# Windows (PowerShell)
Get-Content $env:USERPROFILE\.claude.json | ConvertFrom-Json
```

#### ⚠️ CRITICAL DIFFERENCE

**Claude Code requires `"type": "stdio"` in every MCP server configuration!**

This is the #1 reason configs fail. Claude Desktop and Cursor don't need this field.

<details>
<summary><strong>Option 1: Simple Setup (mcp-cursor - Recommended)</strong></summary>

```json
{
  "mcpServers": {
    "mcp-cursor": {
      "command": "npx",
      "args": ["-y", "mcp-cursor"],
      "type": "stdio"
    }
  }
}
```

**Install the server:**
```bash
npm install -g mcp-cursor
```

</details>

<details>
<summary><strong>Option 2: Shared Memory Setup</strong></summary>

**Step 1: Create shared memory file** (if not already created)

**macOS/Linux:**
```bash
mkdir -p ~/claude-mcp-configs
touch ~/claude-mcp-configs/shared-memory.json
```

**Windows (PowerShell):**
```powershell
New-Item -Path $env:USERPROFILE\claude-mcp-configs -ItemType Directory -Force
New-Item -Path $env:USERPROFILE\claude-mcp-configs\shared-memory.json -ItemType File -Force
```

**Step 2: Install memory server**
```bash
npm install -g @modelcontextprotocol/server-memory
```

**Step 3: Add to config**

**macOS/Linux config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"
      ],
      "type": "stdio"
    }
  }
}
```

**⚠️ CRITICAL**: Replace `YOUR_USERNAME` with your actual username!

**Windows config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "C:\\Users\\YOUR_USERNAME\\claude-mcp-configs\\shared-memory.json"
      ],
      "type": "stdio"
    }
  }
}
```

**⚠️ CRITICAL**: Replace `YOUR_USERNAME` with your actual username!

</details>

<details>
<summary><strong>Option 3: Advanced Setup (Multiple Servers)</strong></summary>

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "type": "stdio"
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/directory"
      ],
      "type": "stdio"
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
      "type": "stdio"
    }
  }
}
```

**Install servers:**
```bash
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking
```

</details>

<details>
<summary><strong>Verification</strong></summary>

#### Step 1: Verify Config File Exists and is Valid

**Check if config file exists:**
```bash
# macOS/Linux
ls -la ~/.claude.json

# Windows (PowerShell)
Test-Path $env:USERPROFILE\.claude.json
```

**Validate JSON syntax:**

**macOS/Linux:**
```bash
cat ~/.claude.json | python3 -m json.tool
```

**Windows (CMD):**
```cmd
type %USERPROFILE%\.claude.json | python -m json.tool
```

**Windows (PowerShell):**
```powershell
Get-Content $env:USERPROFILE\.claude.json | ConvertFrom-Json
```

#### Step 2: Verify MCP Servers are Loaded

**Check MCP servers:**
```bash
claude mcp list
```

**Expected output:**
```
Available MCP servers:
- shared-memory (active)
- filesystem (active)
...etc..
```

#### Step 3: Test MCP Functionality in Claude Code

**Start Claude Code session:**
```bash
claude
```

**Test commands in the interactive session:**

**Test 1: Check available tools**
```
What MCP tools do you have access to?
```

**Test 2: Test Memory Server**
```
Remember that my project is called "MyAwesomeApp"
```

**Test 3: Verify Memory Persistence**
```
What's my project name?
```

**Expected responses:**
- Should list all configured MCP servers
- Should confirm memory storage
- Should return "MyAwesomeApp" from memory

#### Step 4: Advanced Verification Commands

**Check server status:**
```bash
claude mcp status
```

**Test specific server:**
```bash
claude mcp test memory
```

**View server logs:**
```bash
claude mcp logs
```

#### Step 5: Troubleshooting

**If `claude mcp list` shows no servers:**
1. Check JSON syntax with validation commands above
2. Verify all file paths are correct (no `YOUR_USERNAME` placeholders)
3. Ensure `"type": "stdio"` is present in all server configs
4. Restart terminal and try again

**If servers show as inactive:**
1. Check if MCP packages are installed: `npm list -g | grep mcp`
2. Verify server commands are correct
3. Check for port conflicts

#### No Restart Needed!

Claude Code automatically picks up config changes. Just start a new session:
```bash
claude
```

</details>

---

### 2.3: 🎯 Cursor IDE - Complete Setup

#### Installation

**macOS:**
- Download from [cursor.com](https://cursor.com)
- Or install via Homebrew: `brew install --cask cursor`

**Windows:**
- Download from [cursor.com](https://cursor.com)
- Run the installer

**Linux:**
- AppImage available from [cursor.com](https://cursor.com)

#### Configuration Options

Cursor supports two configuration approaches:

**Global Config** (affects all projects):
- Accessed via Cursor Settings → MCP
- Stored in Cursor's global settings

**Project Config** (per-project, version controlled):
- File: `.cursor/mcp.json` in project root
- ✅ Recommended for teams
- Can be committed to git

#### Finding Config Files via Cursor UI

**Global Configuration:**

**All platforms:**
1. Open Cursor IDE
2. Press `Cmd/Ctrl + ,` to open Settings
3. In the search bar, type **"MCP"**
4. You'll see **"MCP Servers"** section
5. Click **"Edit in settings.json"** to open the global config file
6. The file will open in Cursor's editor showing the full path

**Alternative method:**
1. Press `Cmd/Ctrl + Shift + P` (Command Palette)
2. Type **"Preferences: Open Settings (JSON)"**
3. Press Enter
4. Look for MCP-related settings in the JSON file

**Project Configuration:**

**All platforms:**
1. Open your project in Cursor
2. In the **Explorer** panel (left sidebar), look for `.cursor` folder
3. If it doesn't exist, you'll need to create it (see setup instructions below)
4. Click on `.cursor` folder to expand it
5. Look for `mcp.json` file
6. Right-click on `mcp.json` → **"Reveal in File Explorer"** (Windows) or **"Reveal in Finder"** (macOS) to see the full path

**Finding the .cursor folder if it's hidden:**
1. In Cursor's Explorer panel, right-click in empty space
2. Select **"Refresh Explorer"** to ensure all files are shown
3. If still not visible, the folder doesn't exist yet and needs to be created

**Command Palette method:**
1. Press `Cmd/Ctrl + Shift + P`
2. Type **"File: Reveal Active File in Explorer"** (Windows) or **"File: Reveal Active File in Finder"** (macOS)
3. This will open the file location in your system's file manager

#### Global Configuration Setup

1. Open Cursor
2. Press `Cmd/Ctrl + ,` (Settings)
3. Search for "MCP"
4. Click "Edit in settings.json"

#### Project Configuration Setup

**macOS/Linux:**
```bash
# In your project directory
mkdir -p .cursor
touch .cursor/mcp.json

# Edit
code .cursor/mcp.json
```

**Windows (PowerShell):**
```powershell
# In your project directory
New-Item -Path .cursor -ItemType Directory -Force
New-Item -Path .cursor\mcp.json -ItemType File -Force

# Edit
code .cursor\mcp.json
```

#### Understanding Your Cursor Config Structure

Before adding MCP servers, check what's already in your config file:

**Scenario 1: Empty or New Config File**
If your config is empty, create the entire structure:
```json
{
  "mcpServers": {
    // Your MCP server configurations go here
  }
}
```

**Scenario 2: Existing Config with Empty mcpServers**
Your config might look like this:
```json
{
  "mcpServers": {}
}
```

**Scenario 3: Existing Config with Populated mcpServers**
Your config might already have MCP servers:
```json
{
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"]
    }
  }
}
```

#### How to Locate and Edit the mcpServers Section in Cursor

**For Global Configuration:**
1. Open Cursor Settings (`Cmd/Ctrl + ,`)
2. Search for "MCP"
3. Click "Edit in settings.json"
4. Look for `"mcpServers":` in the JSON file
5. Add or modify servers as needed

**For Project Configuration:**
1. Open your project in Cursor
2. Navigate to `.cursor/mcp.json` in the Explorer panel
3. Open the file in Cursor's editor
4. Look for `"mcpServers":` in the file
5. Add or modify servers as needed

**Step-by-step editing process:**
- **For empty config**: Add the entire structure (see examples below)
- **For existing config**: Add new servers inside the existing `mcpServers` object
- **Note**: Cursor does NOT require `"type": "stdio"` (unlike Claude Code)
- **Always ensure proper JSON syntax** with commas between multiple servers

**Example: Adding to existing config with other servers**
```json
{
  "mcpServers": {
    "existing-server": {
      "command": "npx",
      "args": ["-y", "some-existing-server"]
    },
    "new-memory-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

**Validate your JSON:**
- Cursor will show syntax errors in real-time
- Use `Cmd/Ctrl + Shift + P` → "Format Document" to auto-format
- Check for red squiggly lines indicating JSON errors

<details>
<summary><strong>Option 1: Simple Setup (mcp-cursor - Recommended)</strong></summary>

```json
{
  "mcpServers": {
    "mcp-cursor": {
      "command": "npx",
      "args": ["-y", "mcp-cursor"]
    }
  }
}
```

**Install the server:**
```bash
npm install -g mcp-cursor
```

</details>

<details>
<summary><strong>Option 2: Shared Memory Setup</strong></summary>

**Step 1: Create shared memory file** (if not already created)

**macOS/Linux:**
```bash
mkdir -p ~/claude-mcp-configs
touch ~/claude-mcp-configs/shared-memory.json
```

**Windows (PowerShell):**
```powershell
New-Item -Path $env:USERPROFILE\claude-mcp-configs -ItemType Directory -Force
New-Item -Path $env:USERPROFILE\claude-mcp-configs\shared-memory.json -ItemType File -Force
```

**Step 2: Install memory server**
```bash
npm install -g @modelcontextprotocol/server-memory
```

**Step 3: Add to config**

**macOS/Linux config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"
      ]
    }
  }
}
```

**Windows config:**
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "C:\\Users\\YOUR_USERNAME\\claude-mcp-configs\\shared-memory.json"
      ]
    }
  }
}
```

</details>

<details>
<summary><strong>Option 3: Advanced Setup (Multiple Servers)</strong></summary>

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/directory"
      ]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    }
  }
}
```

**Install servers:**
```bash
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking
```

</details>

#### Applying Changes

After editing config:

1. Press `Cmd/Ctrl + Shift + P`
2. Type "Reload Window"
3. Press Enter

Or restart Cursor completely.

<details>
<summary><strong>Verification</strong></summary>

#### Step 1: Verify Config File Exists and is Valid

**For Global Configuration:**
```bash
# Check if global settings contain MCP config
# Open Cursor Settings (Cmd/Ctrl + ,) and search for "MCP"
```

**For Project Configuration:**
```bash
# Check if project config exists
ls -la .cursor/mcp.json

# Windows (PowerShell)
Test-Path .cursor\mcp.json
```

**Validate JSON syntax:**
```bash
# Project config
cat .cursor/mcp.json | python3 -m json.tool

# Windows (PowerShell)
Get-Content .cursor\mcp.json | ConvertFrom-Json
```

#### Step 2: Verify MCP Servers in Cursor UI

**Visual verification in Cursor:**
1. Open Cursor IDE
2. Press `Cmd/Ctrl + ,` to open Settings
3. Search for **"MCP"**
4. Look for **"MCP Servers"** section
5. Your configured servers should appear in the list with **green status indicators**

**Expected UI elements:**
- ✅ **Green dot/checkmark** next to each server name
- ✅ **"Active" or "Connected"** status text
- ✅ **Server details** showing command and arguments

#### Step 3: Test MCP Functionality in Cursor Chat

**Open Cursor Chat:**
1. Press `Cmd/Ctrl + L` to open chat
2. Or click the chat icon in the sidebar

**Test commands:**

**Test 1: Check available tools**
```
What MCP tools do you have access to?
```

**Test 2: Test Memory Server**
```
Remember that my current project is "CursorMCPTest"
```

**Test 3: Test Filesystem Server (if configured)**
```
List the files in the current project directory
```

**Test 4: Verify Memory Persistence**
```
What's my current project name?
```

**Expected responses:**
- Should list all configured MCP servers
- Should confirm memory storage
- Should show actual project files
- Should return "CursorMCPTest" from memory

#### Step 4: Advanced Verification

**Check MCP server status in Command Palette:**
1. Press `Cmd/Ctrl + Shift + P`
2. Type **"MCP"** to see MCP-related commands
3. Look for commands like:
   - **"MCP: Show Server Status"**
   - **"MCP: Restart Servers"**
   - **"MCP: View Logs"**

**Check Developer Console:**
1. Press `Cmd/Ctrl + Shift + I` (or `F12`)
2. Look for MCP-related messages in the console
3. Check for any error messages

#### Step 5: Troubleshooting

**If MCP servers don't appear in settings:**
1. Check JSON syntax with validation commands above
2. Verify all file paths are correct (no `YOUR_USERNAME` placeholders)
3. Restart Cursor completely
4. Check if using global vs project config correctly

**If servers show as inactive/red:**
1. Check if MCP packages are installed: `npm list -g | grep mcp`
2. Verify server commands are correct
3. Check Cursor's developer console for error messages
4. Try restarting MCP servers via Command Palette

**If chat doesn't recognize MCP tools:**
1. Reload Cursor window: `Cmd/Ctrl + Shift + P` → "Reload Window"
2. Check that servers are active in MCP settings
3. Verify the chat is using the correct model that supports MCP

</details>

<details>
<summary><strong>Project Config Version Control</strong></summary>

If using `.cursor/mcp.json`:

**Add to .gitignore** (if using sensitive paths):
```gitignore
# Don't commit absolute paths
.cursor/mcp.json
```

**Or create a template**:
```json
{
  "mcpServers": {
    "shared-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "${HOME}/claude-mcp-configs/shared-memory.json"
      ]
    }
  }
}
```

**Note**: Cursor doesn't expand environment variables, so team members need to update paths manually.

</details>

---

## Part 3: Testing Shared Memory Across All Tools

**After setting up Option 2 (Shared Memory) in any or all of the products above:**

### Comprehensive Cross-Tool Testing Workflow

#### Step 1: Verify Shared Memory File Exists
```bash
# Check if shared memory file was created
ls -la ~/claude-mcp-configs/shared-memory.json

# Windows (PowerShell)
Test-Path $env:USERPROFILE\claude-mcp-configs\shared-memory.json
```

#### Step 2: Test Memory Storage in Each Tool

**Test in Claude Desktop:**
1. Open Claude Desktop
2. Start a new conversation
3. Ask: **"Remember that my project name is AcmeApp and my favorite framework is React"**
4. Verify response confirms memory storage

**Test in Claude Code:**
1. Open terminal and run: `claude`
2. Ask: **"What's my project name and favorite framework?"**
3. Should respond: **"Your project name is AcmeApp and your favorite framework is React"**

**Test in Cursor:**
1. Open Cursor IDE
2. Open chat (`Cmd/Ctrl + L`)
3. Ask: **"What's my project name and favorite framework?"**
4. Should respond: **"Your project name is AcmeApp and your favorite framework is React"**

#### Step 3: Verify Cross-Tool Memory Persistence

**Advanced test sequence:**
1. **In Claude Desktop**: "Remember that I'm working on a Node.js API with PostgreSQL"
2. **In Claude Code**: Ask "What database am I using for my API?"
3. **In Cursor**: Ask "What technology stack am I using?"
4. **Back to Claude Desktop**: Ask "What's my current tech stack?"

**Expected results:**
- All tools should remember the Node.js API and PostgreSQL information
- Memory should persist across tool switches
- No information should be lost

#### Step 4: Visual Verification of Active MCP Servers

**Claude Desktop:**
- Look for MCP tools indicator in the interface
- Should show memory server as active/connected

**Claude Code:**
- Run `claude mcp list` - should show shared-memory as active
- Check server status with `claude mcp status`

**Cursor:**
- Settings → MCP → should show shared-memory with green status
- Command Palette → "MCP: Show Server Status"

#### Step 5: Troubleshooting Shared Memory Issues

**If memory doesn't persist across tools:**
1. Verify all tools use the same memory file path
2. Check file permissions on the shared memory file
3. Ensure no `YOUR_USERNAME` placeholders remain in configs
4. Restart all applications after config changes

**If memory works in one tool but not others:**
1. Check that all tools have the shared-memory server configured
2. Verify the memory file path is identical across all configs
3. Check for JSON syntax errors in each config file

**Success indicators:**
- ✅ All three tools return the same information
- ✅ Memory persists across tool switches
- ✅ No "memory not found" or "file not found" errors
- ✅ MCP servers show as active/green in all tools

If all tests pass, your shared memory works perfectly! 🎉

---

## Part 4: Advanced MCP Servers

<details>
<summary><strong>Filesystem Access</strong></summary>

**When**: You need file operations beyond basic memory.

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Config** (add to existing `mcpServers`):
```json
"filesystem": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-filesystem",
    "/path/to/allowed/directory1",
    "/path/to/allowed/directory2",
    "/path/to/allowed/directory3",
    ...
  ]
}
```

**Security**: Only grant access to directories you trust.

</details>

<details>
<summary><strong>Sequential Thinking (Advanced Reasoning)</strong></summary>

**When**: Complex problem-solving, multi-step tasks.

```bash
npm install -g @modelcontextprotocol/server-sequential-thinking
```

**Config**:
```json
"sequential-thinking": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
}
```

**Usage**: In any tool, ask "Use sequential thinking to break down this problem..."

</details>

---

## Part 5: Troubleshooting

<details>
<summary><strong>Complete Troubleshooting Guide</strong></summary>

### Issue: Username Placeholders Not Replaced

**Symptoms**: MCP servers fail to start, "file not found" errors, or path-related errors

**Fix**: This is the #1 cause of setup failures. You MUST replace all `YOUR_USERNAME` placeholders:

**Find your username:**
```bash
# macOS/Linux
whoami
# or
echo $USER

# Windows (Command Prompt)
echo %USERNAME%

# Windows (PowerShell)
$env:USERNAME
```

**Common replacements needed:**
- `/Users/YOUR_USERNAME/` → `/Users/ACTUAL_USERNAME/`
- `C:\\Users\\YOUR_USERNAME\\` → `C:\\Users\\ACTUAL_USERNAME\\`
- `%USERPROFILE%` → `C:\Users\ACTUAL_USERNAME` (Windows)

**Example**: If your username is `john`:
```json
// ❌ WRONG
"/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"

// ✅ CORRECT  
"/Users/john/claude-mcp-configs/shared-memory.json"
```

**Search and replace in your config files:**
- Use your text editor's "Find and Replace" feature
- Search for: `YOUR_USERNAME`
- Replace with: your actual username
- Make sure to replace ALL instances in the file

### Issue: Directory Path Placeholders Not Replaced

**Symptoms**: Filesystem MCP server fails, "permission denied" errors, or "directory not found" errors

**Fix**: Replace all `/path/to/allowed/directory` placeholders with actual directory paths:

**Common directory paths to use:**
```bash
# macOS/Linux - Your home directory
/Users/YOUR_USERNAME
/home/YOUR_USERNAME

# macOS/Linux - Specific project directories
/Users/YOUR_USERNAME/Documents
/Users/YOUR_USERNAME/Projects
/Users/YOUR_USERNAME/Desktop

# Windows
C:\Users\YOUR_USERNAME
C:\Users\YOUR_USERNAME\Documents
C:\Users\YOUR_USERNAME\Projects
```

**Example filesystem configuration:**
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/john/Documents",
        "/Users/john/Projects"
      ]
    }
  }
}
```

**Security Note**: Only grant access to directories you trust. Never use `/` (root) or system directories.

### Issue: MCP Server Not Found

**Symptoms**: Claude can't see your MCP tools

**Fix**:
```bash
# Verify installation
npm list -g | grep modelcontextprotocol

# Try reinstalling
npm install -g @modelcontextprotocol/server-memory --force
```

### Issue: Config Not Loading

**Claude Desktop:**

**macOS:**
```bash
# Quit application completely
osascript -e 'quit app "Claude"'

# Check logs
tail -f ~/Library/Logs/Claude/mcp*.log

# Verify config syntax
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool
```

**Windows (PowerShell):**
```powershell
# Stop Claude process
Stop-Process -Name "Claude" -Force

# Check logs
Get-Content $env:APPDATA\Claude\logs\mcp*.log -Tail 50

# Verify config syntax
Get-Content $env:APPDATA\Claude\claude_desktop_config.json | ConvertFrom-Json
```

**Linux:**
```bash
# Quit application
killall claude

# Check logs
tail -f ~/.config/Claude/logs/mcp*.log

# Verify config syntax
cat ~/.config/Claude/claude_desktop_config.json | python3 -m json.tool
```

**Claude Code:**
```bash
# Works on all platforms
claude mcp list

# Verify config syntax (cross-platform)
cat ~/.claude.json | python3 -m json.tool        # macOS/Linux
type %USERPROFILE%\.claude.json | python -m json.tool  # Windows CMD
Get-Content $env:USERPROFILE\.claude.json | ConvertFrom-Json  # Windows PowerShell
```

**Cursor**:
1. `Cmd/Ctrl + Shift + P` → "Reload Window"
2. Check MCP settings in Cursor Settings panel

### Issue: "command not found: npx"

**macOS:**
```bash
# Reinstall Node properly
brew install node

# Verify installation
which npx
npx --version

# If still not found, add to PATH
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**Windows (PowerShell as Administrator):**
```powershell
# Reinstall Node using official installer from nodejs.org
# Or use package manager:
choco install nodejs     # Chocolatey
# or
winget install OpenJS.NodeJS   # winget

# Verify
npx --version

# If still not found, add to PATH manually:
# System Properties → Environment Variables → Path → Edit
# Add: C:\Program Files\nodejs\
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nodejs npm

# Fedora/RHEL
sudo dnf install nodejs npm

# Verify
which npx
npx --version

# If still not found
export PATH="$PATH:/usr/local/bin"
echo 'export PATH="$PATH:/usr/local/bin"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: Port Already in Use

**When**: Running multiple instances of same MCP server

**Fix**: Only run **one instance per server type**. If you have mcp-cursor, you don't need separate memory/filesystem servers.

</details>

---

## Part 6: What NOT to Install

<details>
<summary><strong>Avoid Redundancy</strong></summary>

If you installed `mcp-cursor`, **DO NOT** also install:
- `@modelcontextprotocol/server-memory` (already included)
- `@modelcontextprotocol/server-filesystem` (already included)  
- `@modelcontextprotocol/server-sequential-thinking` (already included)

</details>

<details>
<summary><strong>Multiple Sequential Thinking Servers</strong></summary>

**NEVER run these together**:
- Official sequential-thinking
- Enhanced sequential-thinking
- Sequential-thinking-tools

**Pick ONE**. Multiple sequential servers cause conflicts and duplicate responses.

</details>

---

## Part 7: Pro Setup

<details>
<summary><strong>Desktop Extensions (.dxt files)</strong></summary>

**New in 2025**: Install MCP servers with one click.

1. Download `.dxt` file from MCP server repo
2. Double-click to install
3. Auto-configures Claude Desktop

**No terminal required!**

</details>

<details>
<summary><strong>Verification Script</strong></summary>

**macOS/Linux:**

Save this as `verify-mcp.sh`:

```bash
#!/bin/bash
echo "=== MCP Setup Verification ==="

echo -e "\n1. Checking Node.js..."
node --version || echo "❌ Node.js not found"

echo -e "\n2. Checking Claude Code config..."
if [ -f ~/.claude.json ]; then
    echo "✅ ~/.claude.json exists"
    cat ~/.claude.json | python3 -m json.tool > /dev/null 2>&1 && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
else
    echo "❌ ~/.claude.json not found"
fi

echo -e "\n3. Checking Claude Desktop config..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    CONFIG_PATH=~/Library/Application\ Support/Claude/claude_desktop_config.json
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CONFIG_PATH=~/.config/Claude/claude_desktop_config.json
fi

if [ -f "$CONFIG_PATH" ]; then
    echo "✅ Claude Desktop config exists"
    cat "$CONFIG_PATH" | python3 -m json.tool > /dev/null 2>&1 && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
else
    echo "❌ Claude Desktop config not found"
fi

echo -e "\n4. Checking installed MCP packages..."
npm list -g 2>/dev/null | grep -E 'mcp|modelcontextprotocol' || echo "❌ No MCP packages found"

echo -e "\n=== Verification Complete ==="
```

Run:
```bash
chmod +x verify-mcp.sh && ./verify-mcp.sh
```

**Windows (PowerShell):**

Save this as `verify-mcp.ps1`:

```powershell
Write-Host "=== MCP Setup Verification ===" -ForegroundColor Cyan

Write-Host "`n1. Checking Node.js..." -ForegroundColor Yellow
try {
    node --version
    Write-Host "✅ Node.js installed" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js not found" -ForegroundColor Red
}

Write-Host "`n2. Checking Claude Code config..." -ForegroundColor Yellow
$claudeConfig = "$env:USERPROFILE\.claude.json"
if (Test-Path $claudeConfig) {
    Write-Host "✅ ~/.claude.json exists" -ForegroundColor Green
    try {
        Get-Content $claudeConfig | ConvertFrom-Json | Out-Null
        Write-Host "✅ Valid JSON" -ForegroundColor Green
    } catch {
        Write-Host "❌ Invalid JSON" -ForegroundColor Red
    }
} else {
    Write-Host "❌ ~/.claude.json not found" -ForegroundColor Red
}

Write-Host "`n3. Checking Claude Desktop config..." -ForegroundColor Yellow
$desktopConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $desktopConfig) {
    Write-Host "✅ Claude Desktop config exists" -ForegroundColor Green
    try {
        Get-Content $desktopConfig | ConvertFrom-Json | Out-Null
        Write-Host "✅ Valid JSON" -ForegroundColor Green
    } catch {
        Write-Host "❌ Invalid JSON" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Claude Desktop config not found" -ForegroundColor Red
}

Write-Host "`n4. Checking installed MCP packages..." -ForegroundColor Yellow
$mcpPackages = npm list -g 2>$null | Select-String -Pattern "(mcp|modelcontextprotocol)"
if ($mcpPackages) {
    Write-Host "✅ MCP packages found:" -ForegroundColor Green
    $mcpPackages | ForEach-Object { Write-Host $_.Line }
} else {
    Write-Host "❌ No MCP packages found" -ForegroundColor Red
}

Write-Host "`n=== Verification Complete ===" -ForegroundColor Cyan
```

Run:
```powershell
.\verify-mcp.ps1
```

**Note for Windows**: You may need to enable script execution:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

</details>

---

<details>
<summary><strong>Quick Start Checklist</strong></summary>

- [ ] Node.js v16+ installed
- [ ] Choose: mcp-cursor (simple) or individual servers (advanced)
- [ ] Edit Claude Desktop config at correct path
- [ ] Edit Claude Code config at ~/.claude.json (add "type": "stdio")
- [ ] Edit Cursor config (global or project)
- [ ] Restart all applications
- [ ] Test with "Remember X" in one tool, query in another
- [ ] Verify with `claude mcp list` (CLI)

</details>

---

## Next Steps

**You now have**:
✅ Working MCP servers across all three tools  
✅ Shared memory for cross-tool context  
✅ Foundation for advanced capabilities

**Learn next**:
- Advanced reasoning servers (chain-of-thought, meta-cognition)
- Custom slash commands for team workflows
- Production debugging and observability

**Common additions**:
- Brave Search MCP (web search)
- GitHub MCP (repo integration)
- Linear/Sentry MCP (project management)

---

## Resources

- [Official MCP Documentation](https://modelcontextprotocol.io)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [Claude Code Best Practices](https://anthropic.com/engineering/claude-code-best-practices)
- [Cursor MCP Guide](https://cursor.com/docs/context/mcp)

### Visual References and Screenshots

**Note**: Screenshots showing active MCP servers with green status indicators are available in the official documentation:

- **Claude Desktop MCP Interface**: Shows MCP tools indicator and active server status
- **Claude Code MCP Commands**: Screenshots of `claude mcp list` output showing active servers
- **Cursor MCP Settings**: Visual guide showing green status indicators in Settings → MCP
- **MCP Server Status Indicators**: Examples of what active vs inactive servers look like

**For the most up-to-date screenshots and visual guides:**
- Check the official MCP documentation for current UI screenshots
- Visit the GitHub repositories for each tool for latest interface examples
- Community forums often have helpful screenshots of working configurations

**Questions?** Drop them in the comments. I respond to every setup issue.

---

## Feedback & Contributions

**Found an Issue? Have a Suggestion?**

We want to keep this guide accurate and helpful! If you encounter any problems, find mistakes, or have suggestions for improvements, please let us know:

- **Issues or Errors**: If something doesn't work as described, please report it
- **Outdated Information**: MCP and AI tools evolve rapidly—let us know if you find outdated content
- **Missing Steps**: If you needed additional steps not covered here, share them
- **Improvements**: Have ideas to make this guide clearer or more comprehensive?

**How to Contribute:**
- **Create a Pull Request (PR)**: Submit improvements, corrections, or enhancements directly
- **Open an Issue**: Report problems or suggest changes
- **Leave Comments**: Share feedback and questions
- **Share Your Solutions**: Help others with your experience

Your feedback and contributions help everyone in the community. See [CONTRIBUTING](../../../CONTRIBUTING.md) for guidelines on submitting PRs and other contributions.

---

## Resources and References

See [Resources and References](./resources-and-references.md)

---
Return to [Blog posts home](../README.md)
--- 

*This guide synthesizes information from official documentation, community resources, and practical testing. All package names, commands, and configurations have been verified as of January 2025. For the latest updates, always refer to official documentation.*

*Found this helpful? Share it with your team. Debugging MCP configs wastes hours—let's save everyone that time.*