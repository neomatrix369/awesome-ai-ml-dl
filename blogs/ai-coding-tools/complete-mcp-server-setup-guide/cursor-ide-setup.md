# Cursor IDE - Complete MCP Server Setup

![Cursor IDE banner](https://imgs.search.brave.com/Q2uzDhe3slS3dOelWW90UrGEAg1Ff-NEoHeuLL-hvCU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YmxlZXBzdGF0aWMu/Y29tL2NvbnRlbnQv/aGwtaW1hZ2VzLzIw/MjUvMDcvMTMvY3Vy/c29yLWhlYWRlci5q/cGc)

**[← Back to Main Guide](./post.md)** | **[← Previous: Claude Code Setup](./claude-code-setup.md)** | **[Next: Advanced MCP Servers →](./advanced-mcp-servers.md)**

## Overview

Cursor is a modern AI-first IDE built on VS Code, offering a full development environment with integrated AI assistance and MCP server support.

**Best for**: Full IDE experience, VS Code users

---

## Installation

**macOS:**
- Download from [cursor.com](https://cursor.com)
- Or install via Homebrew: `brew install --cask cursor`

**Windows:**
- Download from [cursor.com](https://cursor.com)
- Run the installer

**Linux:**
- AppImage available from [cursor.com](https://cursor.com)

---

## Configuration Options

**Global Config** (affects all projects):
- Accessed via Cursor Settings → MCP
- Stored in Cursor's global settings
- File: `~/.cursor/mcp.json` (macOS/Linux) | `%USERPROFILE%\.cursor\mcp.json` (Windows)

---

## Finding Config Files via Cursor UI

### Global Configuration

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

### Global Configuration via Finder/Windows/File Explorer

**All platforms:**
1. Open your Home Directory in a Finder/Windows/File Explorer
2. In the **Explorer** window look for the `.cursor` folder
3. If it doesn't exist, you'll need to create it (see setup instructions below)
4. Click on `.cursor` folder to expand it
5. Look for `mcp.json` file
6. Right-click on `mcp.json` and select your text editor of choice

---

## Global Configuration Setup via Cursor

1. Open Cursor
2. Press `Cmd/Ctrl + ,` (Settings)
3. Search for "MCP"
4. Click "Edit in settings.json"

---

## Configuration Setup

**macOS/Linux:**
```bash
# In your Home directory
mkdir -p ~/.cursor
touch ~/.cursor/mcp.json

# Edit
code ~/.cursor/mcp.json
```

**Windows (PowerShell):**
```powershell
# In your home directory
New-Item -Path $env:USERPROFILE\.cursor -ItemType Directory -Force
New-Item -Path $env:USERPROFILE\.cursor\mcp.json -ItemType File -Force

# Edit
code $env:USERPROFILE\.cursor\mcp.json
```

---

## Understanding Your Cursor Config Structure

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

---

## How to Locate and Edit the mcpServers Section

**For Global Configuration via Cursor:**
1. Open Cursor Settings (`Cmd/Ctrl + ,`)
2. Search for "MCP"
3. Click "Edit in settings.json"
4. Look for `"mcpServers":` in the JSON file
5. Add or modify servers as needed

**For Global Configuration via Finder/Windows/File Explorer:**
1. Open your Home directory in Finder/Windows/File Explorer
2. Navigate to `~/.cursor/mcp.json` in the Finder/Windows/File Explorer panel
3. Open the file in an editor of your choice
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

---

## Configuration Options

### Option 1: Shared Memory Setup

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

### Option 2: Advanced Setup (Combined steps)

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

After editing config:

1. Press `Cmd/Ctrl + Shift + P`
2. Type "Reload Window"
3. Press Enter

Or restart Cursor completely.

---

## Verification

### Step 1: Verify Config File Exists and is Valid

**For Global Configuration via Cursor:**
```bash
# Check if global settings contain MCP config
# Open Cursor Settings (Cmd/Ctrl + ,) and search for "MCP"
```

**For Global Configuration via CLI:**
```bash
# Check if config exists

# macOS/Linux
ls -la ~/.cursor/mcp.json

# Windows (PowerShell)
Test-Path $env:USERPROFILE\.cursor\mcp.json
```

**Validate JSON syntax:**
```bash
# Global config

# macOS/Linux
cat ~/.cursor/mcp.json | python3 -m json.tool

# Windows (PowerShell)
Get-Content $env:USERPROFILE\.cursor\mcp.json | ConvertFrom-Json
```

### Step 2: Verify MCP Servers in Cursor UI

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

### Step 3: Test MCP Functionality in Cursor Chat

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

### Step 4: Advanced Verification

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

### Step 5: Troubleshooting

**If MCP servers don't appear in settings:**
1. Check JSON syntax with validation commands above
2. Verify all file paths are correct (no `YOUR_USERNAME` placeholders)
3. Restart Cursor completely
4. Check if using global config correctly

**If servers show as inactive/red:**
1. Check if MCP packages are installed: `npm list -g | grep mcp`
2. Verify server commands are correct
3. Check Cursor's developer console for error messages
4. Try restarting MCP servers via Command Palette

**If chat doesn't recognize MCP tools:**
1. Reload Cursor window: `Cmd/Ctrl + Shift + P` → "Reload Window"
2. Check that servers are active in MCP settings
3. Verify the chat is using the correct model that supports MCP

---

**Note**: Cursor doesn't expand environment variables, so users need to update paths manually.

---

**[← Back to Main Guide](./post.md)** | **[← Previous: Claude Code Setup](./claude-code-setup.md)** | **[Next: Advanced MCP Servers →](./advanced-mcp-servers.md)**
