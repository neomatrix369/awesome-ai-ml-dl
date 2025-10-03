# Pro Setup & Advanced Tools

**[← Back to Main Guide](./post.md)**

## Overview

Advanced setup tools and workflows for power users, teams, and production environments.

---

## Desktop Extensions (.dxt files)

**New in 2025**: Install MCP servers with one click.

1. Download `.dxt` file from MCP server repo
2. Double-click to install
3. Auto-configures Claude Desktop

**No terminal required!**

**Benefits:**
- One-click installation
- Automatic configuration
- No JSON editing needed
- Perfect for non-technical users

**Where to find .dxt files:**
- Check the [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- Look for releases with `.dxt` files
- Follow installation instructions in each server's README

---

## Verification Script

Use these scripts to quickly verify your MCP setup across all tools.

### macOS/Linux

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

### Windows (PowerShell)

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

## Team Setup Best Practices

### Version Control for Cursor Projects

**Recommended approach for teams:**

1. **Create a template config** in `.cursor/mcp.json.template`:
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

2. **Add to `.gitignore`**:
```gitignore
.cursor/mcp.json
```

3. **Document setup in README**:
```markdown
## MCP Setup

1. Copy `.cursor/mcp.json.template` to `.cursor/mcp.json`
2. Replace `${HOME}` with your actual home directory path
3. Install MCP servers: `npm install -g @modelcontextprotocol/server-memory`
```

### Centralized Team Config Repository

For larger teams, consider:

1. Create a dedicated config repo with templates for all tools
2. Include setup scripts for each platform
3. Document MCP server choices and their purpose
4. Share verification scripts

---

## Production Environment Setup

### Environment Variables for API Keys

Never hardcode API keys in config files:

**Bad:**
```json
{
  "mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "actual-api-key-here"
      }
    }
  }
}
```

**Good:**
```json
{
  "mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-brave-search"],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      }
    }
  }
}
```

Then set environment variable:
```bash
# macOS/Linux
export BRAVE_API_KEY="your-api-key"

# Windows (PowerShell)
$env:BRAVE_API_KEY = "your-api-key"
```

### CI/CD Integration

For Claude Code in CI/CD pipelines:

1. Store `.claude.json` template in repo
2. Use environment variables for sensitive data
3. Install MCP servers in build step
4. Test MCP functionality before deployment

**Example GitHub Actions workflow:**
```yaml
- name: Setup MCP Servers
  run: |
    npm install -g @modelcontextprotocol/server-memory
    cp .claude.json.template ~/.claude.json
    # Replace placeholders with actual values from secrets
```

---

## Monitoring and Debugging

### Enable Detailed Logging

**Claude Desktop:**
```bash
# macOS
tail -f ~/Library/Logs/Claude/mcp*.log

# Windows
Get-Content $env:APPDATA\Claude\logs\mcp*.log -Tail 50 -Wait

# Linux
tail -f ~/.config/Claude/logs/mcp*.log
```

**Claude Code:**
```bash
claude mcp logs --follow
```

**Cursor:**
1. Open Developer Tools (`Cmd/Ctrl + Shift + I`)
2. Check Console for MCP-related messages
3. Enable verbose logging in settings

### Performance Monitoring

Track MCP server performance:

```bash
# Check memory usage
ps aux | grep mcp

# Monitor server startup time
time npx -y @modelcontextprotocol/server-memory --help
```

---

## Advanced Configuration Patterns

### Multiple Memory Files for Different Contexts

```json
{
  "mcpServers": {
    "project-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "/Users/YOUR_USERNAME/mcp-memory/project-a.json"
      ]
    },
    "personal-memory": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-memory",
        "--memory-file",
        "/Users/YOUR_USERNAME/mcp-memory/personal.json"
      ]
    }
  }
}
```

### Conditional Server Activation

Use environment variables to conditionally enable servers:

```bash
# Development
export MCP_ENV="development"

# Production
export MCP_ENV="production"
```

Then in scripts, activate different servers based on `MCP_ENV`.

---

**[← Back to Main Guide](./post.md)** | **[← Previous: Troubleshooting](./troubleshooting.md)**
