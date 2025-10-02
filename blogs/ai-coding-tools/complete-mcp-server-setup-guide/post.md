# The Complete MCP Server Setup Guide: Claude Desktop, Claude Code, and Cursor

*Stop wasting time with broken configs. Here's the setup that actually works.*

## Why This Guide Exists

You've probably stumbled across 5 different blog posts about MCP (Model Context Protocol) servers, tried 3 different configs, and ended up with nothing working. The documentation is scattered, package names are wrong in popular guides, and nobody tells you which config file goes where.

This guide fixes that. One comprehensive walkthrough for all three tools.

## Quick Reference: Which Tool When?

Before we dive into setup, understand what you're installing:

| Tool | Best For | Interface | Config Location |
|------|----------|-----------|-----------------|
| **Claude Desktop** | GUI workflows, exploring projects | Desktop app | `~/Library/Application Support/Claude/claude_desktop_config.json` (Mac) |
| **Claude Code** | Terminal workflows, CI/CD, scripting | CLI | `~/.claude.json` |
| **Cursor IDE** | Full IDE experience, VS Code users | Desktop IDE | `.cursor/config.json` (project) or global settings |

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

#### Option 1: Simple Setup (mcp-cursor - Recommended)

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

#### Option 2: Shared Memory Setup

**Best for**: Sharing context across Claude Desktop, Claude Code, and Cursor

**Step 1: Create shared memory file**

**Architecture**
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

**⚠️ Important**: Replace `YOUR_USERNAME` with your actual username. Use absolute paths only.

#### Option 3: Advanced Setup (Multiple Servers)

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

#### Verification & Troubleshooting

**Check logs:**

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

**Validate JSON syntax:**

**macOS/Linux:**
```bash
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json | python3 -m json.tool
```

**Windows (PowerShell):**
```powershell
Get-Content $env:APPDATA\Claude\claude_desktop_config.json | ConvertFrom-Json
```

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

#### ⚠️ CRITICAL DIFFERENCE

**Claude Code requires `"type": "stdio"` in every MCP server configuration!**

This is the #1 reason configs fail. Claude Desktop and Cursor don't need this field.

#### Option 1: Simple Setup (mcp-cursor - Recommended)

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

#### Option 2: Shared Memory Setup

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

#### Option 3: Advanced Setup (Multiple Servers)

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

#### Verification

**Check MCP servers:**
```bash
claude mcp list
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

#### No Restart Needed!

Claude Code automatically picks up config changes. Just start a new session:
```bash
claude
```

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

#### Option 1: Simple Setup (mcp-cursor - Recommended)

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

#### Option 2: Shared Memory Setup

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

#### Option 3: Advanced Setup (Multiple Servers)

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

#### Applying Changes

After editing config:

1. Press `Cmd/Ctrl + Shift + P`
2. Type "Reload Window"
3. Press Enter

Or restart Cursor completely.

#### Verification

1. Open Cursor Settings → MCP
2. Check that your servers appear in the list
3. Test by asking in chat: "What MCP tools do you have access to?"

#### Project Config Version Control

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

---

## Part 3: Testing Shared Memory Across All Tools

**After setting up Option 2 (Shared Memory) in any or all of the products above:**

1. **In Claude Desktop**: "Remember that my project name is AcmeApp"
2. **In Claude Code**: `claude` (start session), then ask "What's my project name?"
3. **In Cursor**: Open chat, ask "What's my project name?"

If all three return "AcmeApp", your shared memory works! 🎉

---

## Part 4: Advanced MCP Servers

### Filesystem Access

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

### Sequential Thinking (Advanced Reasoning)

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

---

## Part 5: Troubleshooting

<details>
<summary><strong>Complete Troubleshooting Guide</strong></summary>

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

### Avoid Redundancy

If you installed `mcp-cursor`, **DO NOT** also install:
- `@modelcontextprotocol/server-memory` (already included)
- `@modelcontextprotocol/server-filesystem` (already included)  
- `@modelcontextprotocol/server-sequential-thinking` (already included)

### Multiple Sequential Thinking Servers

**NEVER run these together**:
- Official sequential-thinking
- Enhanced sequential-thinking
- Sequential-thinking-tools

**Pick ONE**. Multiple sequential servers cause conflicts and duplicate responses.

---

## Part 7: Pro Setup

### Desktop Extensions (.dxt files)

**New in 2025**: Install MCP servers with one click.

1. Download `.dxt` file from MCP server repo
2. Double-click to install
3. Auto-configures Claude Desktop

**No terminal required!**

### Verification Script

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

---

## Quick Start Checklist

- [ ] Node.js v16+ installed
- [ ] Choose: mcp-cursor (simple) or individual servers (advanced)
- [ ] Edit Claude Desktop config at correct path
- [ ] Edit Claude Code config at ~/.claude.json (add "type": "stdio")
- [ ] Edit Cursor config (global or project)
- [ ] Restart all applications
- [ ] Test with "Remember X" in one tool, query in another
- [ ] Verify with `claude mcp list` (CLI)

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