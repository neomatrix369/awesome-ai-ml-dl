# Complete Troubleshooting Guide

**[← Back to Main Guide](./post.md)**

## Overview

This guide covers common MCP server setup issues and their solutions across all platforms and tools.

---

## Issue: Username Placeholders Not Replaced

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

---

## Issue: Directory Path Placeholders Not Replaced

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

---

## Issue: MCP Server Not Found

**Symptoms**: Claude can't see your MCP tools

**Fix**:
```bash
# Verify installation
npm list -g | grep modelcontextprotocol

# Try reinstalling
npm install -g @modelcontextprotocol/server-memory --force
```

---

## Issue: Config Not Loading

### Claude Desktop

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

### Claude Code

```bash
# Works on all platforms
claude mcp list

# Verify config syntax (cross-platform)
cat ~/.claude.json | python3 -m json.tool        # macOS/Linux
type %USERPROFILE%\.claude.json | python -m json.tool  # Windows CMD
Get-Content $env:USERPROFILE\.claude.json | ConvertFrom-Json  # Windows PowerShell
```

### Cursor

1. `Cmd/Ctrl + Shift + P` → "Reload Window"
2. Check MCP settings in Cursor Settings panel

---

## Issue: "command not found: npx"

### macOS

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

### Windows (PowerShell as Administrator)

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

### Linux

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

---

## Issue: Port Already in Use

**When**: Running multiple instances of same MCP server

**Fix**: Only run **one instance per server type**. If you have mcp-cursor, you don't need separate memory/filesystem servers.

---

## Issue: Missing "type": "stdio" in Claude Code Config

**Symptoms**: Claude Code doesn't recognize MCP servers

**Fix**: Claude Code requires `"type": "stdio"` in every MCP server configuration:

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "type": "stdio"  // ← Required for Claude Code!
    }
  }
}
```

**Note**: Claude Desktop and Cursor do NOT need this field.

---

## Issue: Invalid JSON Syntax

**Symptoms**: Config file not loading, errors on startup

**Fix**: Validate your JSON syntax:

**Common mistakes:**
- Missing commas between server entries
- Trailing comma after last entry
- Missing closing braces or brackets
- Using single quotes instead of double quotes

**Validation commands:**
```bash
# macOS/Linux
cat ~/.claude.json | python3 -m json.tool

# Windows (PowerShell)
Get-Content $env:USERPROFILE\.claude.json | ConvertFrom-Json
```

---

## Issue: Memory Doesn't Persist Across Tools

**Symptoms**: Memory works in one tool but not others

**Fix**:
1. Verify all tools use the **same memory file path**
2. Check file permissions on the shared memory file
3. Ensure no `YOUR_USERNAME` placeholders remain
4. Restart all applications after config changes

**Verify shared memory path:**
```bash
# All tools should point to the same file
# Example correct path:
/Users/john/claude-mcp-configs/shared-memory.json

# Check the file exists:
ls -la ~/claude-mcp-configs/shared-memory.json
```

---

## Issue: Shared Memory File Not Created

**Symptoms**: "File not found" error when MCP server starts

**Fix**: Manually create the shared memory file:

**macOS/Linux:**
```bash
mkdir -p ~/claude-mcp-configs
touch ~/claude-mcp-configs/shared-memory.json
echo '{}' > ~/claude-mcp-configs/shared-memory.json
```

**Windows (PowerShell):**
```powershell
New-Item -Path $env:USERPROFILE\claude-mcp-configs -ItemType Directory -Force
Set-Content -Path $env:USERPROFILE\claude-mcp-configs\shared-memory.json -Value '{}'
```

---

## Issue: MCP Server Crashes on Startup

**Symptoms**: Server starts then immediately stops

**Fix**:
1. Check logs for specific error messages
2. Verify all dependencies are installed
3. Try reinstalling the MCP server package
4. Check for conflicting server instances

**Reinstall server:**
```bash
npm uninstall -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-memory
```

---

## Quick Diagnostic Checklist

Use this checklist to quickly identify common issues:

- [ ] Node.js v16+ installed (`node --version`)
- [ ] npm/npx working (`npx --version`)
- [ ] MCP packages installed (`npm list -g | grep mcp`)
- [ ] Config file exists and is valid JSON
- [ ] All `YOUR_USERNAME` placeholders replaced
- [ ] All `/path/to/allowed/directory` placeholders replaced
- [ ] Shared memory file created (if using shared memory)
- [ ] `"type": "stdio"` added (if using Claude Code)
- [ ] Application restarted after config changes
- [ ] No multiple instances of same server type

---

## Getting Additional Help

If you're still experiencing issues:

1. **Check the logs** for specific error messages
2. **Search GitHub issues** in the [MCP Server Registry](https://github.com/modelcontextprotocol/servers/issues)
3. **Ask in community forums** with:
   - Your operating system
   - The tool you're using (Claude Desktop/Code/Cursor)
   - Relevant config snippet (remove sensitive info)
   - Error messages from logs
4. **Review official documentation** for your specific MCP server

---

**[← Back to Main Guide](./post.md)** | **[← Previous: Advanced MCP Servers](./advanced-mcp-servers.md)** | **[Next: Pro Setup →](./pro-setup.md)**
