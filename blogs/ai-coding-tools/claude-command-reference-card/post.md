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

### Official Documentation

**Anthropic / Claude**
- Claude Code Overview: https://docs.claude.com/en/docs/claude-code/overview
- Claude Code Best Practices: https://anthropic.com/engineering/claude-code-best-practices
- Claude Code MCP Integration: https://docs.claude.com/en/docs/claude-code/mcp
- IDE Integrations: https://docs.claude.com/en/docs/claude-code/ide-integrations
- Model Context Protocol: https://www.anthropic.com/news/model-context-protocol

**Model Context Protocol (MCP)**
- Official Site: https://modelcontextprotocol.io
- Documentation: https://modelcontextprotocol.io/docs/develop/connect-local-servers
- Examples: https://modelcontextprotocol.io/examples
- MCP Servers Repository: https://github.com/modelcontextprotocol/servers

**Cursor IDE**
- MCP Documentation: https://cursor.com/docs/context/mcp
- Rules for AI: https://cursor.com/docs/context/rules
- MCP Directory: https://cursor.directory/mcp

### Command References

**Essential Guides**
1. "Claude Code Commands Every Developer Should Know" - Travis Media: https://travis.media/blog/claude-code-commands-developer-should-know/
2. "Claude Code: The Complete Guide" - Siddharth Bharath: https://www.siddharthbharath.com/claude-code-the-complete-guide/
3. "Claude Code Quick Reference" - DevHints: https://devhints.io/claude-code
4. "Builder.io Claude Code Guide": https://www.builder.io/blog/claude-code

**Video Tutorials**
- Claude Code Quickstart: https://www.youtube.com/watch?v=0iGEpx8IeM0
- Advanced Usage: https://www.youtube.com/watch?v=UAxr6bWonFs
- IDE Integration: https://www.youtube.com/watch?v=XgZ7mtbCrqk

### The Ultrathink Investigation

**Critical Research**
1. "The Ultrathink Mystery: Does Claude Really Think Harder?" - iTecs Online: https://itecsonline.com/post/the-ultrathink-mystery-does-claude-really-think-harder
2. "Claude Code Ultrathink Secret Prompt" - Wenai Dev: https://www.wenaidev.com/blog/en/claude-code-ultrathink-secret-prompt
3. "Claude Code Thinking Levels" - Goat Review: https://goatreview.com/claude-code-thinking-levels-think-ultrathink/
4. Reddit Discussion: https://www.reddit.com/r/ClaudeAI/comments/1lpvj7z/ultrathink_task_command/

**Key Finding**: Ultrathink only works in Claude Code CLI, not in Claude.ai web interface or Claude Desktop app.

### MCP Server Catalogs

**Official Servers**
- Sequential Thinking: https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking
- Memory Server: https://github.com/modelcontextprotocol/servers/tree/main/src/memory
- Filesystem Server: https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem

**Community Collections**
1. Awesome MCP Servers: https://github.com/wong2/awesome-mcp-servers
2. PipedreamHQ Collection: https://github.com/PipedreamHQ/awesome-mcp-servers
3. TensorBlock Collection: https://github.com/TensorBlock/awesome-mcp-servers
4. Punkpeye Collection: https://github.com/punkpeye/awesome-mcp-servers
5. Habitoai Collection: https://github.com/habitoai/awesome-mcp-servers

**MCP Server Directories**
- MCPServers.org: https://mcpservers.org
- MCP.so: https://mcp.so
- Glama AI: https://glama.ai/mcp/servers
- LobHub: https://lobehub.com/mcp
- PulseMCP: https://www.pulsemcp.com

### Reasoning and Advanced MCP Servers

**Sequential Thinking Implementations**
1. Official Server: https://github.com/modelcontextprotocol/servers/tree/main/src/sequentialthinking
2. Enhanced Version: https://github.com/arben-adm/mcp-sequential-thinking
3. Python Implementation: https://github.com/XD3an/python-sequential-thinking-mcp
4. LangGPT Version: https://github.com/LangGPT/sequential-thinking-mcp
5. Tools Integration: https://github.com/spences10/mcp-sequentialthinking-tools

**Chain of Thought Servers**
- CoT MCP: https://github.com/beverm2391/chain-of-thought-mcp-server
- Chain of Draft: https://github.com/brendancopley/mcp-chain-of-draft-prompt-tool
- DeepSeek Thinker: https://www.flowhunt.io/mcp-servers/deepseek-thinker-mcp/

**Advanced Reasoning**
- Advanced Reasoning MCP: https://lobehub.com/mcp/angrysky56-advanced-reasoning-mcp
- Thinking Patterns: https://lobehub.com/mcp/emmahyde-thinking-patterns
- Comprehensive Thinking Engine: https://github.com/VitalyMalakanov/mcp-thinking
- Thinking Tool: https://www.pulsemcp.com/servers/thinking-tool

**Research Articles**
1. "Sequential Thinking MCP Server Deep Dive" - Skywork AI: https://skywork.ai/skypage/en/A-Deep-Dive-into-the-Sequential-Thinking-MCP-Server
2. "MCP CoT AI Agents Tools" - DZone: https://dzone.com/articles/mcp-cot-ai-agents-tools
3. "Chain of Thought is Probably a Lie" - Dev.to: https://dev.to/aws-builders/chain-of-thought-is-probably-a-lie-and-thats-a-problem-4nkj

### Configuration and Setup

**Setup Guides**
1. "Configuring MCP Tools in Claude Code" - Scott Spence: https://scottspence.com/posts/configuring-mcp-tools-in-claude-code
2. "Setting Up MCP Servers in Claude Code" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1jf4hnt/setting_up_mcp_servers_in_claude_code_a_tech/
3. "How to Connect Cursor to 100+ MCP Servers" - Composio: https://composio.dev/blog/how-to-connect-cursor-to-100-mcp-servers-within-minutes

**Desktop Extensions**
- Official Announcement: https://www.anthropic.com/engineering/desktop-extensions
- Usage Guide: https://www.anthropic.com/news/claude-code-remote-mcp

### Community Resources

**Forums and Discussions**
- Reddit r/ClaudeAI: https://www.reddit.com/r/ClaudeAI/
- Reddit r/mcp: https://www.reddit.com/r/mcp/
- Reddit r/cursor: https://www.reddit.com/r/cursor/
- Cursor Forum: https://forum.cursor.com

**Notable Discussions**
1. "My Claude Workflow Guide" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1ji8ruv/my_claude_workflow_guide_advanced_setup_with_mcp/
2. "What IDE Do I Use with Claude Code?" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1kpd2m6/what_ide_do_i_use_with_claude_code/
3. "Do You Use Any Memory MCP?" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1kvot1c/genuine_question_do_you_use_any_kind_memory_mcp/

### Productivity and Best Practices

**Advanced Usage**
1. "My Claude Code Tips for Newer Users" - Reddit: https://www.reddit.com/r/ClaudeAI/comments/1mpeefp/my_claude_code_tips_for_newer_users/
2. "Awesome Claude Code" - GitHub: https://github.com/hesreallyhim/awesome-claude-code
3. "Building Cursor with Cursor" - Dev.to: https://dev.to/zachary62/building-cursor-with-cursor-a-step-by-step-guide-to-creating-your-own-ai-coding-agent-17c4

**Technical Deep Dives**
1. "Why MCP Won" - Latent Space: https://www.latent.space/p/why-mcp-won
2. "Model Context Protocol Introduction" - Guangzhengli: https://guangzhengli.com/blog/en/model-context-protocol
3. "MCP Security Framework" - HackerNoon: https://hackernoon.com/mcp-is-a-security-heres-how-the-agent-security-framework-fixes-it
4. "Neo4j Chain/Tree of Thought" - LinkedIn: https://www.linkedin.com/pulse/helloworld-neo4j-chaintree-of-thought-prompting-mcp-servers-singh-wtu2c

### Tool Support

**Node.js / NPM**
- Official Downloads: https://nodejs.org
- npm Documentation: https://docs.npmjs.com
- nvm (Node Version Manager): https://github.com/nvm-sh/nvm

**Package Managers**
- Homebrew (macOS): https://brew.sh
- Chocolatey (Windows): https://chocolatey.org
- Winget (Windows): https://learn.microsoft.com/windows/package-manager/winget/

### Related Projects

**Memory and Storage**
- Basic Memory: https://docs.basicmemory.com/integrations/cursor/
- Graphiti MCP: https://blog.getzep.com/cursor-adding-memory-with-graphiti-mcp/
- AI Memory: https://github.com/ipenywis/aimemory
- Memory Keeper: https://lobehub.com/mcp/mkreyman-mcp-memory-keeper

**Debugging and Testing**
- MCP Inspector: https://github.com/modelcontextprotocol/inspector
- Claude Debugs For You: https://github.com/jasonjmcghee/claude-debugs-for-you
- VS Code Extension: https://marketplace.visualstudio.com/items?itemName=JasonMcGhee.claude-debugs-for-you

### Comparison Resources

**Claude Code vs Other Tools**
1. "Claude Code vs Cursor" - Qodo: https://www.qodo.ai/blog/claude-code-vs-cursor/
2. "Claude Code vs Cursor Comparison" - Pragmatic Coders: https://www.pragmaticcoders.com/blog/claude-code-vs-cursor
3. "Cursor vs Claude Code" - Builder.io: https://www.builder.io/blog/cursor-vs-claude-code
4. "Claude Code vs Cursor Comparison" - Northflank: https://northflank.com/blog/claude-code-vs-cursor-comparison
5. "Cursor vs Claude Code" - Haihai AI: https://www.haihai.ai/cursor-vs-claude-code/

### Support

**Official Support**
- Claude Support: https://support.claude.com
- Anthropic Documentation: https://docs.anthropic.com
- Cursor Documentation: https://cursor.com/docs

**Community Support**
- Discord Servers (check official sites)
- GitHub Issues on respective repositories
- Stack Overflow tags: #claude-ai, #mcp, #cursor-ide

---

*Updated: January 2025 • Command reference compiled from official documentation, community testing, and verified research on Claude Code, MCP servers, and reasoning capabilities. The ultrathink investigation represents comprehensive analysis of multiple sources confirming CLI-only functionality.*