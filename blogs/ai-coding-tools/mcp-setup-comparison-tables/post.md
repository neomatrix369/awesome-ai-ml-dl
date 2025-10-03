# MCP Setup Comparison Tables

*Quick-reference tables for choosing tools, servers, and configurations*

---

## Table 1: Tool Comparison - Claude Code vs Cursor vs Claude Desktop

| Feature | Claude Code CLI | Cursor IDE | Claude Desktop |
|---------|----------------|------------|----------------|
| **Interface** | Terminal/CLI | Full IDE (VS Code fork) | GUI Desktop App |
| **Best For** | Automation, CI/CD, scripting | Full development workflow | Exploratory work, conversations |
| **Ultrathink Support** | ✅ Yes (actually works) | ❌ No (treated as text) | ❌ No (treated as text) |
| **Config File** | `~/.claude.json` | `~/.cursor/mcp.json` (global) | `~/Library/Application Support/Claude/` |
| **Config Type** | `"type": "stdio"` required | Standard MCP format | Standard MCP format |
| **MCP Verification** | `claude mcp list` | Settings panel | No built-in verification |
| **Custom Commands** | `.claude/commands/*.md` | `.cursor/rules/*.mdc` | Not supported |
| **IDE Integration** | `/ide` command | Native | Not applicable |
| **Memory Sharing** | ✅ Via shared MCP | ✅ Via shared MCP | ✅ Via shared MCP |
| **Pricing** | Free tier available | Paid ($20/month) | Free tier + Pro options |
| **Installation** | `npm install -g` | Download app | Download app |
| **Primary Use Case** | Power users, DevOps | Full-time coding | Chat, research, planning |

---

## Table 2: MCP Server Decision Matrix

| Server | Use When | Avoid When | Conflicts With |
|--------|----------|------------|----------------|
| **mcp-cursor** | Starting out, simple setup | Need specialized features | Memory, Filesystem, Sequential servers (it includes them) |
| **server-memory** | Need persistent context | Using mcp-cursor | mcp-cursor (redundant) |
| **server-filesystem** | File operations required | Using mcp-cursor | mcp-cursor (redundant) |
| **server-sequential-thinking** | Complex reasoning tasks | Using mcp-cursor | mcp-cursor, other sequential servers |
| **server-brave-search** | Need web search | Don't have API key | Native Claude search |
| **context7** | API documentation lookup | Working offline | None |
| **chain-of-thought** | Need reasoning transparency | Already using sequential | Sequential thinking servers |
| **advanced-reasoning** | Meta-cognition needed | Simple tasks sufficient | None (complementary) |

**Golden Rule**: If you install `mcp-cursor`, DO NOT install `server-memory`, `server-filesystem`, or `server-sequential-thinking` separately.

---

## Table 3: Configuration Differences

| Aspect | Claude Code | Cursor IDE | Claude Desktop |
|--------|-------------|------------|----------------|
| **Config Path** | `~/.claude.json` | `~/.cursor/mcp.json` (global settings) | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| **Required Fields** | `"type": "stdio"` | Standard format | Standard format |
| **Scope Options** | user, project, local | global | global only |
| **Version Control** | Cannot commit `~/.claude.json` | Cannot commit `~/.cursor/mcp.json` | Don't commit (user-specific) |
| **Verification** | `claude mcp list` | Cursor settings panel | Check logs |
| **Hot Reload** | Automatic | Requires window reload | Requires full restart |
| **Multiple Configs** | 3 scopes supported | 2 scopes supported | 1 scope only |

### Example: Same Server, Different Configs

**Claude Code** (`~/.claude.json`):
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "type": "stdio"
    }
  }
}
```

**Cursor** (`~/.cursor/mcp.json`):
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

**Claude Desktop**:
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

**Key Difference**: Only Claude Code needs `"type": "stdio"`

---

## Table 4: Reasoning Server Comparison

| Server | Accuracy Potential | Complexity | Conflicts | Best Use Case |
|--------|-------------------|------------|-----------|---------------|
| **Sequential Thinking (Official)** | 60-70% | Medium | Other sequential servers | General multi-step reasoning |
| **Enhanced Sequential** | 65-75% | Medium-High | Other sequential servers | Advanced stepping with metadata |
| **Chain of Thought** | 70-80% | High | Sequential servers | Transparent reasoning trace |
| **Chain of Draft** | 75-85% | High | Sequential servers | Multi-LLM iteration |
| **Advanced Reasoning** | 70-80% | High | None | Meta-cognition, hypothesis testing |
| **Thinking Patterns** | N/A | Low | None | Mental models, frameworks |
| **Comprehensive Thinking** | Variable | Very High | Sequential servers | 19 different thinking modes |

### Conflict Matrix

| Server A | Server B | Compatible? | Notes |
|----------|----------|-------------|-------|
| Sequential Thinking | Chain of Thought | ❌ No | Both do stepping - choose one |
| Sequential Thinking | Advanced Reasoning | ✅ Yes | Different capabilities |
| Sequential Thinking | Thinking Patterns | ✅ Yes | Complementary |
| Chain of Thought | Chain of Draft | ❌ No | Same purpose, different approach |
| Advanced Reasoning | Thinking Patterns | ✅ Yes | Work together well |
| mcp-cursor | Any sequential server | ❌ No | mcp-cursor includes sequential |

---

## Table 5: Package Name Corrections

| ❌ WRONG (old guides) | ✅ CORRECT (use this) | Notes |
|----------------------|---------------------|-------|
| `@mcp-plugins/memory` | `@modelcontextprotocol/server-memory` | Common error in QED42 guide |
| `@mcp-plugins/file-system` | `@modelcontextprotocol/server-filesystem` | Hyphen vs no hyphen matters |
| `@mcp-plugins/sequential` | `@modelcontextprotocol/server-sequential-thinking` | Different package entirely |
| Installing via `npm install mcp-*` | `npm install -g @modelcontextprotocol/server-*` | Must use full scoped name |

**Impact**: Wrong package names cause 80% of failed installations.

---

## Table 6: Command Availability

| Command/Feature | Claude Code CLI | Cursor IDE | Claude Desktop |
|----------------|----------------|------------|----------------|
| `/init` | ✅ Yes | ❌ No | ❌ No |
| `/ide` | ✅ Yes | N/A (is IDE) | ❌ No |
| `/mcp` | ✅ Yes | Via settings | Via logs |
| `ultrathink` | ✅ Works | ❌ Placebo | ❌ Placebo |
| `think hard` | ✅ Works | ❌ Placebo | ❌ Placebo |
| `Escape` interrupt | ✅ Yes | ✅ Yes | ❌ No |
| `--resume` flag | ✅ Yes | N/A | N/A |
| `--memory` flag | ✅ Yes | N/A | N/A |
| `-p` headless | ✅ Yes | N/A | N/A |
| Custom commands | `.claude/commands/` | `.cursor/rules/` | ❌ No |

---

## Table 7: Setup Complexity

| Approach | Time to Setup | Difficulty | Maintenance | Recommended For |
|----------|--------------|------------|-------------|-----------------|
| **mcp-cursor only** | 10 minutes | Easy | Low | Beginners, most users |
| **Individual servers** | 30 minutes | Medium | Medium | Power users |
| **Shared memory all tools** | 45 minutes | Medium | Medium | Team workflows |
| **Full reasoning stack** | 60+ minutes | Hard | High | Advanced users |
| **Desktop extensions (.dxt)** | 2 minutes | Very Easy | Very Low | Non-technical users |

---

## Table 8: Troubleshooting Guide

| Symptom | Likely Cause | Quick Fix | Verify Fix |
|---------|--------------|-----------|------------|
| MCP server not found | Wrong package name | Install `@modelcontextprotocol/server-*` | `npm list -g` |
| Config ignored | App not restarted | Fully quit and restart | Check logs |
| "stdio" error | Missing in Claude Code | Add `"type": "stdio"` | `claude mcp list` |
| Port conflict | Duplicate servers | Remove redundant config | Restart services |
| Command not recognized | Wrong tool | Check if feature supported | See Table 6 |
| Ultrathink not working | Wrong interface | Only works in CLI | Use Claude Code CLI |
| Memory not shared | Different file paths | Use absolute paths | Test cross-tool |

---

## Table 9: Performance Characteristics

| Configuration | Startup Time | Response Latency | Memory Usage | Best For |
|--------------|--------------|------------------|--------------|----------|
| No MCP servers | Instant | Fast | Low | Quick queries |
| mcp-cursor only | +2-3s | Medium | Medium | Daily coding |
| Memory + Filesystem | +4-5s | Medium | Medium | Project work |
| Full reasoning stack | +8-10s | Slower | High | Complex problems |
| 5+ MCP servers | +15s+ | Variable | High | Specialized workflows |

**Optimization Tip**: Only enable MCP servers you actually use regularly.

---

## Table 10: Platform-Specific Paths and Commands

### Config File Locations

| Tool | macOS | Windows | Linux |
|------|-------|---------|-------|
| **Claude Desktop** | `~/Library/Application Support/Claude/claude_desktop_config.json` | `%APPDATA%\Claude\claude_desktop_config.json` | `~/.config/Claude/claude_desktop_config.json` |
| **Claude Code** | `~/.claude.json` | `%USERPROFILE%\.claude.json` | `~/.claude.json` |
| **Cursor** | `~/.cursor/mcp.json` | `%USERPROFILE%\.cursor\mcp.json` | `~/.cursor/mcp.json` |

### Log File Locations

| Tool | macOS | Windows | Linux |
|------|-------|---------|-------|
| **Claude Desktop** | `~/Library/Logs/Claude/` | `%APPDATA%\Claude\logs\` | `~/.config/Claude/logs/` |
| **Claude Code** | Same as Claude Desktop | Same as Claude Desktop | Same as Claude Desktop |

### Opening Config Files

| Tool | macOS Command | Windows Command | Linux Command |
|------|--------------|-----------------|---------------|
| **Claude Desktop** | `open ~/Library/Application\ Support/Claude/claude_desktop_config.json` | `notepad %APPDATA%\Claude\claude_desktop_config.json` | `xdg-open ~/.config/Claude/claude_desktop_config.json` |
| **Claude Code** | `nano ~/.claude.json` | `notepad %USERPROFILE%\.claude.json` | `nano ~/.claude.json` |

### Restarting Applications

| Tool | macOS | Windows | Linux |
|------|-------|---------|-------|
| **Claude Desktop** | `Cmd+Q` (Quit App) | Right-click tray → Exit | Quit from menu or `killall claude` |
| **Claude Code** | Automatic after config change | Automatic after config change | Automatic after config change |
| **Cursor** | `Cmd+Shift+P` → Reload Window | `Ctrl+Shift+P` → Reload Window | `Ctrl+Shift+P` → Reload Window |

### Path Format in JSON

| OS | Path Format | Example |
|----|-------------|---------|
| **macOS** | Forward slashes | `/Users/username/claude-mcp-configs/memory.json` |
| **Windows** | Double backslashes | `C:\\Users\\username\\claude-mcp-configs\\memory.json` |
| **Linux** | Forward slashes | `/home/username/claude-mcp-configs/memory.json` |

**Important**: Always use absolute paths in config files, not environment variables like `~` or `%USERPROFILE%`

## Table 11: Node.js Installation by Platform

| Platform | Recommended Method | Alternative Methods | Verify Installation |
|----------|-------------------|---------------------|---------------------|
| **macOS** | Homebrew: `brew install node` | Official installer from nodejs.org<br>nvm: `nvm install node` | `node --version`<br>`npm --version`<br>`which npx` |
| **Windows** | Official installer from nodejs.org | Chocolatey: `choco install nodejs`<br>winget: `winget install OpenJS.NodeJS`<br>nvm-windows | `node --version`<br>`npm --version`<br>`where npx` |
| **Linux (Ubuntu/Debian)** | `sudo apt update && sudo apt install nodejs npm` | nvm: `nvm install node`<br>NodeSource repository | `node --version`<br>`npm --version`<br>`which npx` |
| **Linux (Fedora/RHEL)** | `sudo dnf install nodejs npm` | nvm: `nvm install node` | `node --version`<br>`npm --version`<br>`which npx` |
| **Linux (Arch)** | `sudo pacman -S nodejs npm` | nvm: `nvm install node` | `node --version`<br>`npm --version`<br>`which npx` |

### PATH Issues by Platform

| Platform | Common Issue | Solution |
|----------|--------------|----------|
| **macOS** | `npx: command not found` | Add to `~/.zshrc`: `export PATH="/usr/local/bin:$PATH"`<br>Then: `source ~/.zshrc` |
| **Windows** | `npx: command not recognized` | Add to PATH: `C:\Program Files\nodejs\`<br>System Properties → Environment Variables → Path |
| **Linux** | `npx: command not found` | Add to `~/.bashrc`: `export PATH="$PATH:/usr/local/bin"`<br>Then: `source ~/.bashrc` |

---

## Table 12: OS-Specific Troubleshooting

| Issue | macOS Solution | Windows Solution | Linux Solution |
|-------|----------------|------------------|----------------|
| **Config file permissions** | `chmod 644 ~/.claude.json` | No action needed (default permissions) | `chmod 644 ~/.claude.json` |
| **Can't find config directory** | Create: `mkdir -p ~/Library/Application\ Support/Claude` | Create: `md %APPDATA%\Claude` | Create: `mkdir -p ~/.config/Claude` |
| **JSON validation** | `cat file.json \| python3 -m json.tool` | `Get-Content file.json \| ConvertFrom-Json` | `cat file.json \| python3 -m json.tool` |
| **View logs in real-time** | `tail -f ~/Library/Logs/Claude/mcp*.log` | `Get-Content $env:APPDATA\Claude\logs\mcp*.log -Wait` | `tail -f ~/.config/Claude/logs/mcp*.log` |
| **Stop Claude process** | `pkill -9 Claude` or `Cmd+Q` | `Stop-Process -Name "Claude" -Force` | `killall claude` |
| **Clear npm cache** | `npm cache clean --force` | `npm cache clean --force` | `npm cache clean --force` |
| **Reinstall with elevated privileges** | `sudo npm install -g package` | Run PowerShell as Administrator | `sudo npm install -g package` |

```
START: Need MCP setup?
│
├─ Just want to try it? → mcp-cursor
│
├─ Need shared memory across tools? → Individual servers + shared config
│
├─ Complex reasoning required? → Sequential OR Chain-of-Thought (not both)
│
├─ Global settings? → Cursor configs but no version control
│
└─ Production deployment? → Individual servers + observability stack
```

---

## Recommended Starter Configs

### Minimal (Beginner)
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

### Balanced (Most Users)
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project", "/path/to/documents", ...]
    }
  }
}
```

### Advanced (Power Users)
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory", "--memory-file", "/shared/memory.json"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/projects"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "advanced-reasoning": {
      "command": "node",
      "args": ["/path/to/advanced-reasoning-mcp/build/index.js"]
    }
  }
}
```

Note for `advanced-reasoning` above, you need to do this first:

First a place on your projects folder or suitable to clone:

```bash
git clone git@github.com:angrysky56/advanced-reasoning-mcp.git
```

OR

```bash
git clone https://github.com/angrysky56/advanced-reasoning-mcp.git
```

```bash
cd advanced-reasoning-mcp
pwd
```

Note the folder mentioned in the output above. And the replace the `/path/to/advanced-reasoning-mcp/` portion of the config mentioned in the JSON config above with this path.

---

## Resources and References

See [Resources and References](./resources-and-references.md)

---

## Feedback & Contributions

**Found an Issue? Have a Suggestion?**

These comparison tables are maintained with community input. Help us keep them accurate and up-to-date!

- **Incorrect Information**: If a comparison is inaccurate or outdated, please report it
- **Missing Platforms**: Know another platform that supports MCP? Let us know
- **Updated Features**: Platforms evolve—share new capabilities or changes
- **Better Comparisons**: Have ideas for additional comparison dimensions?
- **Real-World Experience**: Share your experience with different platforms

**How to Contribute:**
- **Create a Pull Request (PR)**: Update comparisons, add platforms, or enhance tables
- **Open an Issue**: Report inaccuracies or suggest improvements
- **Share Testing Results**: Contribute your platform experience
- **Suggest New Comparisons**: Help expand the comparison dimensions

The MCP ecosystem changes rapidly. Your feedback and contributions help keep this resource current and valuable for everyone. See [CONTRIBUTING](../../../CONTRIBUTING.md) for guidelines on submitting PRs and other contributions.

---

*These comparison tables synthesize information from over 100 sources including official documentation, community implementations, research articles, and practical testing across macOS, Windows, and Linux platforms. All configurations and package names verified as of January 2025.*

*For the most current information, always refer to official documentation as the MCP ecosystem evolves rapidly.*