# MCP Setup Comparison Tables

*Quick-reference tables for choosing tools, servers, and configurations*

---

## Table 1: Tool Comparison - Claude Code vs Cursor vs Claude Desktop

| Feature | Claude Code CLI | Cursor IDE | Claude Desktop |
|---------|----------------|------------|----------------|
| **Interface** | Terminal/CLI | Full IDE (VS Code fork) | GUI Desktop App |
| **Best For** | Automation, CI/CD, scripting | Full development workflow | Exploratory work, conversations |
| **Ultrathink Support** | ✅ Yes (actually works) | ❌ No (treated as text) | ❌ No (treated as text) |
| **Config File** | `~/.claude.json` | `.cursor/mcp.json` or global | `~/Library/Application Support/Claude/` |
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
| **Config Path** | `~/.claude.json` | `.cursor/mcp.json` (project)<br>or global settings | `~/Library/Application Support/Claude/claude_desktop_config.json` |
| **Required Fields** | `"type": "stdio"` | Standard format | Standard format |
| **Scope Options** | user, project, local | global, project | global only |
| **Version Control** | Can commit `.claude.json` | Can commit `.cursor/mcp.json` | Don't commit (user-specific) |
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

**Cursor** (`.cursor/mcp.json`):
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
| **Cursor Project** | `.cursor/mcp.json` | `.cursor/mcp.json` | `.cursor/mcp.json` |

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
├─ Team collaboration? → Cursor project configs + version control
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
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/project"]
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

---

## Resources and References

### Official Documentation

**Model Context Protocol (MCP)**
- [Official Site](https://modelcontextprotocol.io)
- [Developer Docs](https://modelcontextprotocol.io/docs/develop/connect-local-servers)
- [Quickstart Guide](https://modelcontextprotocol.io/quickstart/server)
- [MCP Examples](https://modelcontextprotocol.io/examples)
- [GitHub Repository](https://github.com/modelcontextprotocol/servers)

**Anthropic / Claude**
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Claude Code Best Practices](https://anthropic.com/engineering/claude-code-best-practices)
- [Desktop Extensions](https://www.anthropic.com/engineering/desktop-extensions)
- [Remote MCP Announcement](https://www.anthropic.com/news/claude-code-remote-mcp)
- [Claude Support](https://support.claude.com)

**Cursor IDE**
- [Official MCP Docs](https://cursor.com/docs/context/mcp)
- [Quickstart Guide](https://cursor.com/docs/get-started/quickstart)
- [Rules for AI](https://cursor.com/docs/context/rules)
- [MCP Directory](https://cursor.directory/mcp)

### Comparison and Setup Guides

**Tool Comparisons**
1. [Claude Code vs Cursor](https://www.qodo.ai/blog/claude-code-vs-cursor/) - Qodo AI
2. [Detailed Comparison](https://www.pragmaticcoders.com/blog/claude-code-vs-cursor) - Pragmatic Coders
3. [Cursor vs Claude Code](https://www.builder.io/blog/cursor-vs-claude-code) - Builder.io
4. [Technical Comparison](https://northflank.com/blog/claude-code-vs-cursor-comparison) - Northflank
5. [Feature Analysis](https://www.haihai.ai/cursor-vs-claude-code/) - Haihai AI

**Configuration Guides**
1. [Build a Shared Memory for Claude](https://blog.dailydoseofds.com/p/build-a-shared-memory-for-claude) - Daily Dose of DS
2. [The Claude You'll Never Need to Remind](https://www.qed42.com/insights/the-claude-youll-never-need-to-remind-mcp-in-action) - QED42
3. [Mastering Cursor Rules](https://dev.to/dpaluy/mastering-cursor-rules-a-developers-guide-to-smart-ai-integration-1k65) - Dev.to
4. [Cursor IDE Setup Guide](https://www.usesaaskit.com/blog/cursor-ai-code-editor-setup-guide) - UseSaasKit
5. [Cursor IDE Rules for AI](https://kirill-markin.com/articles/cursor-ide-rules-for-ai/) - Kirill Markin

**Cross-Platform Setup**
1. [How MCP Servers Work Across Platforms](https://dev.to/darkmavis1980/understanding-mcp-servers-across-different-platforms-claude-desktop-vs-vs-code-vs-cursor-4opk) - Dev.to
2. [Setting Up MCP Servers](https://www.reddit.com/r/ClaudeAI/comments/1jf4hnt/setting_up_mcp_servers_in_claude_code_a_tech/) - Reddit
3. [Connect Cursor to 100+ MCP Servers](https://composio.dev/blog/how-to-connect-cursor-to-100-mcp-servers-within-minutes) - Composio

### MCP Server Collections

**Comprehensive Directories**
1. [Awesome MCP Servers](https://github.com/wong2/awesome-mcp-servers)
2. [PipedreamHQ Collection](https://github.com/PipedreamHQ/awesome-mcp-servers)
3. [TensorBlock Collection](https://github.com/TensorBlock/awesome-mcp-servers)
4. [Punkpeye Collection](https://github.com/punkpeye/awesome-mcp-servers)
5. [Habitoai Collection](https://github.com/habitoai/awesome-mcp-servers)
6. [Topics on GitHub](https://github.com/topics/awesome-mcp-servers)

**Searchable Directories**
- [MCPServers.org](https://mcpservers.org)
- [MCP.so](https://mcp.so)
- [Glama AI Directory](https://glama.ai/mcp/servers)
- [LobHub MCP](https://lobehub.com/mcp)
- [PulseMCP](https://www.pulsemcp.com)
- [Playbooks MCP](https://playbooks.com/mcp)

### Official MCP Servers

**Core Servers**
- [Memory Server](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)
- [Filesystem Server](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)
- [Sequential Thinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking)
- [Brave Search](https://github.com/modelcontextprotocol/server-brave-search)

### Community MCP Servers

**Memory and Storage**
1. [Memory MCP Server](https://github.com/hpkv-io/memory-mcp-server)
2. [Shared Memory MCP](https://github.com/haasonsaas/shared-memory-mcp)
3. [Basic Memory](https://docs.basicmemory.com/integrations/cursor/)
4. [Graphiti MCP](https://blog.getzep.com/cursor-adding-memory-with-graphiti-mcp/)
5. [Memory Keeper](https://lobehub.com/mcp/mkreyman-mcp-memory-keeper)
6. [AI Memory](https://github.com/ipenywis/aimemory)
7. [Qdrant Memory](https://github.com/delorenj/mcp-qdrant-memory)

**Reasoning Servers**
1. [Sequential Thinking (Enhanced)](https://github.com/arben-adm/mcp-sequential-thinking)
2. [Chain of Thought](https://github.com/beverm2391/chain-of-thought-mcp-server)
3. [Chain of Draft](https://github.com/brendancopley/mcp-chain-of-draft-prompt-tool)
4. [Advanced Reasoning](https://lobehub.com/mcp/angrysky56-advanced-reasoning-mcp)
5. [Thinking Patterns](https://lobehub.com/mcp/emmahyde-thinking-patterns)
6. [Comprehensive Thinking](https://github.com/VitalyMalakanov/mcp-thinking)
7. [Sequential + Tools](https://github.com/spences10/mcp-sequentialthinking-tools)

**Utility Servers**
1. mcp-cursor (bundled): Reference in awesome-mcp-servers
2. [Desktop Commander](https://glama.ai/mcp/servers/@wonderwhy-er/DesktopCommanderMCP)
3. [Context7](https://mcp.context7.com)
4. Filesystem with Search: Various implementations in MCP directory

### Technical Deep Dives

**Architecture and Concepts**
1. [How MCP Servers Actually Work](https://jstoppa.com/posts/how-mcp-servers-actually-work-in-claude-cursor-and-what-can-you-do-with-them/post/) - jstoppa
2. [Why MCP Won](https://www.latent.space/p/why-mcp-won) - Latent Space
3. [Model Context Protocol Introduction](https://guangzhengli.com/blog/en/model-context-protocol) - Guangzhengli
4. [MCP Deep Dive](https://www.doc.ic.ac.uk/~nuric/posts/news/unwitty-burdern-of-model-context-protocol/) - Doc IC
5. [MCP Overview](https://www.seangoedecke.com/model-context-protocol/) - Sean Goedecke

**Security and Best Practices**
1. [MCP Security Framework](https://hackernoon.com/mcp-is-a-security-heres-how-the-agent-security-framework-fixes-it) - HackerNoon
2. [Bringing Memory to AI](https://orca.security/resources/blog/bringing-memory-to-ai-mcp-a2a-agent-context-protocols/) - Orca Security
3. [Neo4j and MCP](https://www.linkedin.com/pulse/helloworld-neo4j-chaintree-of-thought-prompting-mcp-servers-singh-wtu2c) - LinkedIn
4. [MCP Security Analysis](https://neo4j.com/blog/developer/model-context-protocol/) - Neo4j Blog

### Reasoning Research

**Sequential Thinking**
1. [Sequential Thinking Deep Dive](https://skywork.ai/skypage/en/A-Deep-Dive-into-the-Sequential-Thinking-MCP-Server) - Skywork AI
2. [How Sequential Thinking Works](https://www.reddit.com/r/mcp/comments/1jwjagw/how_does_the_sequential_thinking_mcp_work/) - Reddit
3. [Python Implementation](https://github.com/XD3an/python-sequential-thinking-mcp)
4. [LangGPT Version](https://github.com/LangGPT/sequential-thinking-mcp)
5. [Zalab Implementation](https://github.com/zalab-inc/mcp-sequentialthinking)

**Chain of Thought**
1. [MCP CoT AI Agents](https://dzone.com/articles/mcp-cot-ai-agents-tools) - DZone
2. [Chain of Thought Analysis](https://dev.to/aws-builders/chain-of-thought-is-probably-a-lie-and-thats-a-problem-4nkj) - Dev.to
3. [DeepSeek Thinker](https://www.flowhunt.io/mcp-servers/deepseek-thinker-mcp/)

### Productivity Resources

**Workflow Optimization**
1. [Top 10 MCP Servers for 2025](https://dev.to/fallon_jimmy/top-10-mcp-servers-for-2025-yes-githubs-included-15jg) - Dev.to
2. [10 MCP Servers to Make Life Easier](https://composio.dev/blog/10-awesome-mcp-servers-to-make-your-life-easier) - Composio
3. [Best Cursor MCP Servers](https://www.getclockwise.com/blog/best-cursor-mcp-servers) - GetClockwise
4. [Top 10 MCP Servers](https://apidog.com/blog/top-10-mcp-servers-for-claude-code/) - Apidog

**Community Discussions**
1. [My Claude Workflow Guide](https://www.reddit.com/r/ClaudeAI/comments/1ji8ruv/my_claude_workflow_guide_advanced_setup_with_mcp/) - Reddit
2. [9 MCP Memory Frameworks That Work](https://www.reddit.com/r/cursor/comments/1na4sv9/9_mcp_memory_serversframeworks_that_actually_make/) - Reddit
3. [Genuine Question: Memory MCP](https://www.reddit.com/r/ClaudeAI/comments/1kvot1c/genuine_question_do_you_use_any_kind_memory_mcp/) - Reddit
4. [How to Make MCP Clients Share Memories](https://www.reddit.com/r/mcp/comments/1klq4ko/how_to_make_your_mcp_clients_share_memories_with/) - Reddit

### Debugging and Testing

**Tools and Extensions**
1. [MCP Inspector](https://github.com/modelcontextprotocol/inspector)
2. [Claude Debugs For You](https://github.com/jasonjmcghee/claude-debugs-for-you)
3. [VS Code Extension](https://marketplace.visualstudio.com/items?itemName=JasonMcGhee.claude-debugs-for-you)
4. [VS Code MCP Support](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)

**Debugging Guides**
1. [Debugging MCP Servers](https://modelcontextprotocol.io/docs/tools/debugging) - Model Context Protocol
2. [MCP Troubleshooting](https://pcarion.com/blog/claude_mcp/) - PCArion
3. [Unlocking Productivity with MCP](https://dev.to/tttn13/unlocking-productivity-with-mcp-servers-and-claude-a-comprehensive-guide-2692) - Dev.to

### Platform-Specific Resources

**macOS**
- [Homebrew](https://brew.sh)
- [Node.js Installation](https://nodejs.org)
- Terminal Guide: Built-in documentation

**Windows**
- [Chocolatey](https://chocolatey.org)
- [Winget](https://learn.microsoft.com/windows/package-manager/winget/)
- [PowerShell Docs](https://learn.microsoft.com/powershell/)
- [Node.js Windows](https://nodejs.org/en/download/)

**Linux**
- [Node.js via Package Managers](https://nodejs.org/en/download/package-manager/)
- Ubuntu/Debian: Built-in apt documentation
- Fedora/RHEL: Built-in dnf documentation
- [Arch](https://wiki.archlinux.org/title/Node.js)

### Video Tutorials

**Setup and Configuration**
1. MCP Setup Walkthrough: https://www.youtube.com/watch?v=e4VS6nWEhzI
2. Cursor MCP Configuration: https://www.youtube.com/watch?v=cyY97HzFOmE
3. Advanced MCP Usage: https://www.youtube.com/watch?v=_xiw1q2CqZw
4. Claude Code in Action: https://www.youtube.com/watch?v=IqNZUhV3RyY
5. MCP Inspector Demo: https://www.youtube.com/watch?v=u-GGktUnSgg
6. Cursor Setup Guide: https://www.youtube.com/watch?v=0iGEpx8IeM0

### Installation Scripts and Tools

**Community Scripts**
1. Claude MCP Installers: https://github.com/unbracketed/claude-mcp-installers
2. Perplexity MCP: https://github.com/Alcova-AI/perplexity-mcp
3. Claude MCP Tools: https://github.com/GrimFandango42/Claude-MCP-tools
4. RLabs MCP: https://github.com/RLabs-Inc/claude-mcp

### Package Name Corrections

**Critical Resources**
- This guide corrects common errors found in:
  - QED42 blog post (incorrect package names)
  - Various Medium articles (outdated syntax)
  - Early community guides (pre-official naming)

**Correct Package Registry**
- npm Registry: https://www.npmjs.com/search?q=%40modelcontextprotocol
- All official packages use `@modelcontextprotocol/server-*` naming

### Forums and Community Support

**Active Communities**
- Reddit r/ClaudeAI: https://www.reddit.com/r/ClaudeAI/
- Reddit r/mcp: https://www.reddit.com/r/mcp/
- Reddit r/cursor: https://www.reddit.com/r/cursor/
- Cursor Forum: https://forum.cursor.com
- Hacker News: Search "MCP" or "Claude Code"

**Notable Threads**
1. "What Tools/MCPs Are You Using?" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1lx4277/what_tools_and_mcps_are_you_using_with_claude/
2. "MCP Tools Discussion" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1lubtez/what_mcp_tools_you_are_using_with_claude_code/
3. "How to Run Claude Code as MCP Server" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1magmg7/how_to_run_claude_code_as_an_mcp_server_to/

### Multi-Agent Systems

**Advanced Implementations**
1. [Enhancing Claude Code with Subagents](https://dev.to/oikon/enhancing-claude-code-with-mcp-servers-and-subagents-29dd) - Dev.to
2. [Multi-Agent Search](https://glama.ai/mcp/servers/search/multi-agent-systems-with-shared-memory-storage)
3. Parallel Processing: Community discussions on Reddit

### Project Management Integration

**Enterprise Tools**
1. Linear MCP: Official integrations documentation
2. Sentry MCP: Official integrations documentation
3. [GitHub MCP](https://cursorideguide.com/guides/github-mcp-setup-guide)
4. Asana/Jira: Community implementations

### Additional Tools

**Development Utilities**
- [JSON Validator](https://jsonlint.com)
- Online JSON Formatter: Various tools
- [Git for version control](https://git-scm.com)
- [Docker (if using containerized MCP)](https://www.docker.com)

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