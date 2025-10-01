# The Claude Command Reference Card

*Your essential guide to Claude Code CLI commands, shortcuts, and MCP servers*

## 🚨 Critical Discovery: The Ultrathink Truth

**Ultrathink ONLY works in Claude Code CLI**

✅ **Works**: Claude Code terminal  
❌ **Doesn't work**: Claude.ai web interface  
❌ **Doesn't work**: Claude Desktop app

If you've been typing "ultrathink" in the web interface, you've been using a placebo. It's just treated as regular text.

---

## Core Slash Commands

### Essential Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/init` | Create CLAUDE.md context file | `/init` |
| `/ide` | Connect to IDE for context sharing | `/ide` |
| `/config` | Access configuration settings | `/config` |
| `/permissions` | Manage allowed tools | `/permissions` |
| `/hooks` | Configure automated workflows | `/hooks` |
| `/help` | Show available commands | `/help` |
| `/clear` | Clear conversation, preserve history | `/clear` |
| `/mcp` | List MCP servers | `/mcp` |

### Custom Commands

Create reusable commands in `.claude/commands/`:

**Example**: `.claude/commands/review.md`
```markdown
Perform comprehensive code review:
1. Check TypeScript/React conventions
2. Verify error handling and loading states
3. Ensure accessibility standards
4. Review test coverage
```

**Usage**: `/review`

---

## Thinking Budget Commands

Progressive reasoning intensity (Claude Code CLI only):

```
think < think hard < think harder < ultrathink
```

| Command | Use When |
|---------|----------|
| `think` | Basic reasoning tasks |
| `think hard` | Complex analysis needed |
| `think harder` | Advanced problem-solving |
| `ultrathink` | Maximum computational budget |

**Example**: `ultrathink: Refactor this legacy codebase with 50k+ lines`

---

## Keyboard Shortcuts

### Universal

| Shortcut | Action |
|----------|--------|
| `Escape` | Interrupt Claude execution (course correction) |
| `Double Escape` | Edit previous prompts in history |
| `Shift+Tab` | Toggle auto-accept mode |

### Platform-Specific

| Platform | Shortcut | Action |
|----------|----------|--------|
| **macOS** | `Cmd+Esc` | Quick launch from IDE |
| **Windows** | `Ctrl+Esc` | Quick launch from IDE |
| **Linux** | `Ctrl+Esc` | Quick launch from IDE |

---

## CLI Arguments

Launch Claude Code with special modes:

**macOS/Linux:**
```bash
# Resume last session
claude --resume

# Enable memory persistence
claude --memory

# Headless mode (automation/CI/CD)
claude -p "Run all tests and report failures"

# Verbose logging (debugging)
claude --verbose
```

**Windows (PowerShell):**
```powershell
# Resume last session
claude --resume

# Enable memory persistence
claude --memory

# Headless mode (automation/CI/CD)
claude -p "Run all tests and report failures"

# Verbose logging (debugging)
claude --verbose
```

**Note**: Commands work the same across all platforms once Claude Code CLI is installed.

---

## Essential MCP Servers

### Core Servers

| Server | Package | Purpose |
|--------|---------|---------|
| **Memory** | `@modelcontextprotocol/server-memory` | Persistent context across sessions |
| **Filesystem** | `@modelcontextprotocol/server-filesystem` | File read/write/search |
| **Sequential Thinking** | `@modelcontextprotocol/server-sequential-thinking` | Multi-step reasoning |

### Reasoning Servers

**Pick ONE from each category to avoid conflicts**:

#### Sequential Reasoning (Choose 1)
- Official: `@modelcontextprotocol/server-sequential-thinking`
- Enhanced: `@arben-adm/mcp-sequential-thinking`

#### Chain of Thought (Choose 1)
- CoT: `beverm2391/chain-of-thought-mcp-server`
- CoD: `brendancopley/mcp-chain-of-draft-prompt-tool`

#### Meta-Cognition (Optional)
- Advanced Reasoning: `angrysky56/advanced-reasoning-mcp`
- Thinking Patterns: `emmahyde/thinking-patterns`

### Productivity Servers

| Server | Use Case |
|--------|----------|
| **Brave Search** | Web search (requires API key) |
| **Context7** | API documentation lookup |
| **GitHub** | Repository integration |
| **Linear/Sentry** | Project management/error tracking |

---

## MCP Configuration Patterns

### Claude Code (`~/.claude.json`)

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
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

**Note**: `"type": "stdio"` required for Claude Code (not for Desktop)

### Claude Desktop

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

### Cursor IDE (`.cursor/mcp.json`)

```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    }
  }
}
```

---

## MCP Best Practices

### ✅ DO

- Run **one instance per server type**
- Use `mcp-cursor` for bundled functionality
- Enable runtime server selection for flexibility
- Store configs in version control (project scope)
- Test with `claude mcp list`

### ❌ DON'T

- Install duplicate servers (e.g., memory + mcp-cursor)
- Run multiple sequential thinking servers simultaneously
- Use outdated package names (`@mcp-plugins/*`)
- Forget `"type": "stdio"` in Claude Code config
- Skip verification after config changes

---

## Common Workflows

### 1. Start New Project
```bash
claude
/init
/ide  # Connect to your editor
# Work in your IDE with full context
```

### 2. Resume Previous Work
```bash
claude --resume
# Continues last session with memory intact
```

### 3. Automated Testing
```bash
claude -p "Run full test suite and analyze failures"
# Headless mode for CI/CD
```

### 4. Complex Problem Solving
```bash
claude
ultrathink: Design scalable architecture for 10M users
# Uses maximum reasoning budget
```

### 5. Team Command Sharing
```bash
# Create .claude/commands/deploy.md
claude
/deploy  # Runs team's standard deployment checklist
```

---

## Troubleshooting Quick Reference

| Issue | Solution |
|-------|----------|
| **Command not found** | Check PATH, reinstall with `npm install -g` |
| **Config ignored** | Restart application completely (Cmd+Q) |
| **MCP not visible** | Verify with `claude mcp list` |
| **Port conflict** | Only run one instance per server |
| **Wrong package name** | Use `@modelcontextprotocol/*` not `@mcp-plugins/*` |
| **Ultrathink not working** | Only works in Claude Code CLI, not web/desktop |

---

## Config File Locations

| Tool | macOS | Windows | Linux |
|------|-------|---------|-------|
| **Claude Code** | `~/.claude.json` | `%USERPROFILE%\.claude.json` | `~/.claude.json` |
| **Claude Desktop** | `~/Library/Application Support/Claude/claude_desktop_config.json` | `%APPDATA%\Claude\claude_desktop_config.json` | `~/.config/Claude/claude_desktop_config.json` |
| **Cursor Global** | Settings → MCP or app database | Settings → MCP or app database | Settings → MCP or app database |
| **Cursor Project** | `.cursor/mcp.json` | `.cursor/mcp.json` | `.cursor/mcp.json` |

---

## Verification Commands

**macOS/Linux:**
```bash
# Check Claude Code setup
claude mcp list

# Verify Node/npm
node --version  # Need v16+
npm list -g | grep modelcontextprotocol

# Test MCP connection
claude
# Then inside Claude: "List available MCP tools"

# Check logs
tail -f ~/Library/Logs/Claude/mcp*.log  # macOS
tail -f ~/.config/Claude/logs/mcp*.log  # Linux
```

**Windows (PowerShell):**
```powershell
# Check Claude Code setup
claude mcp list

# Verify Node/npm
node --version  # Need v16+
npm list -g | Select-String "modelcontextprotocol"

# Test MCP connection
claude
# Then inside Claude: "List available MCP tools"

# Check logs
Get-Content $env:APPDATA\Claude\logs\mcp*.log -Tail 50
```

---

## Quick Installation Script

**macOS/Linux:**

Save as `install-mcp.sh`:
```bash
#!/bin/bash
# Quick MCP Setup for Claude Code

echo "Installing essential MCP servers..."

npm install -g @anthropic-ai/claude-code
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking

echo "✅ Installation complete!"
echo "Now edit ~/.claude.json to configure servers"
claude mcp list
```

Run:
```bash
chmod +x install-mcp.sh && ./install-mcp.sh
```

**Windows (PowerShell):**

Save as `install-mcp.ps1`:
```powershell
# Quick MCP Setup for Claude Code

Write-Host "Installing essential MCP servers..." -ForegroundColor Cyan

npm install -g @anthropic-ai/claude-code
npm install -g @modelcontextprotocol/server-memory
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-sequential-thinking

Write-Host "✅ Installation complete!" -ForegroundColor Green
Write-Host "Now edit $env:USERPROFILE\.claude.json to configure servers" -ForegroundColor Yellow
claude mcp list
```

Run:
```powershell
.\install-mcp.ps1
```

**Note**: On Windows, you may need to run PowerShell as Administrator for global npm installations.

---

## Runtime Server Selection

**Advanced**: Choose MCP server per prompt

Some setups support selecting which reasoning server to use:
- "Use sequential thinking to solve this..."
- "Apply chain-of-thought reasoning for..."
- "Use meta-cognitive analysis to evaluate..."

This prevents conflicts when multiple reasoning servers are installed.

---

## Resources

- **Official Docs**: [docs.claude.com](https://docs.claude.com)
- **MCP Registry**: [github.com/modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)
- **Best Practices**: [anthropic.com/engineering/claude-code-best-practices](https://anthropic.com/engineering/claude-code-best-practices)

---

## Print This Card

This reference is designed to be printed or bookmarked for quick access:
- Commands you'll use daily
- Configuration patterns that actually work
- Troubleshooting without digging through docs

**Share with your team** to establish common workflows.

---

## Resources and References

See [Resources and References](./resources-and-references.md)

---

## Feedback & Contributions

**Found an Issue? Have a Suggestion?**

This reference card aims to be comprehensive and accurate. Help us keep it that way!

- **Incorrect Commands**: If a command doesn't work as documented, please report it
- **Missing Commands**: Know a useful command not listed here? Share it!
- **Better Examples**: Have clearer examples or use cases? We'd love to include them
- **Platform Differences**: Found platform-specific variations? Let us know
- **Typos or Errors**: Even small corrections help everyone

**How to Contribute:**
- **Create a Pull Request (PR)**: Add new commands, fix errors, or enhance examples
- **Open an Issue**: Suggest additions or report problems
- **Share Tips & Tricks**: Contribute your command expertise
- **Update for New Features**: Help keep the reference current

Your contributions make this reference better for the entire community. See [CONTRIBUTING](../../../CONTRIBUTING.md) for guidelines on submitting PRs and other contributions.

---

[Back to AI Coding Tools](../README.md) | [Main Repository](../../../README.md)
