# Claude Desktop - Complete MCP Server Setup

**[← Back to Main Guide](./post.md)**

## Overview

Claude Desktop is Anthropic's official desktop application for Claude, providing a GUI interface for your AI workflows. This guide covers complete MCP server setup for Claude Desktop across macOS, Windows, and Linux.

**Best for**: GUI workflows, exploring projects, visual interactions

---

## Installation

**macOS:**
- Download from [claude.ai](https://claude.ai)
- Or install via Homebrew: `brew install --cask claude`

**Windows:**
- Download from [claude.ai](https://claude.ai)
- Run the installer

**Linux:**
- AppImage available from [claude.ai](https://claude.ai)

---

## Configuration File Location

| OS | Config Path |
|----|-------------|
| **macOS** | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| **Windows** | `%APPDATA%\Claude\claude_desktop_config.json` |
| **Linux** | `~/.config/Claude/claude_desktop_config.json` |

---

## Finding the Config Folder via Claude Desktop UI

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

---

## Initial Setup

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

---

## Understanding Your Claude Desktop Config Structure

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

---

## How to Locate and Edit the mcpServers Section

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

---

## Configuration Options

### Option 1: Shared Memory Setup

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

### Option 2: Advanced Setup (Combined steps)

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

### Option 3: Simple Setup (mcp-cursor - Quicker, less flexible)

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

---

## Applying Changes

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

---

## Verification & Troubleshooting

### Step 1: Verify Config File Exists and is Valid

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

### Step 2: Verify MCP Servers are Running in Claude Desktop

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

### Step 3: Test MCP Functionality

**Test Memory Server:**
1. Ask: **"Remember that my favorite color is blue"**
2. Start a new conversation
3. Ask: **"What's my favorite color?"**
4. Should respond: **"Your favorite color is blue"**

**Test Filesystem Server (if configured):**
1. Ask: **"List the files in my Documents folder"**
2. Should show actual files from your Documents directory

### Step 4: Check Logs for Errors

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

### Step 5: Troubleshooting Common Issues

**If MCP tools don't appear:**
1. Restart Claude Desktop completely
2. Check JSON syntax with validation commands above
3. Verify all file paths are correct (no `YOUR_USERNAME` placeholders)
4. Check logs for specific error messages

**If memory doesn't persist:**
1. Verify shared memory file path is correct
2. Check file permissions on the memory file
3. Ensure the same path is used across all tools

---

**[← Back to Main Guide](./post.md)** | **[Next: Claude Code Setup →](./claude-code-setup.md)**
