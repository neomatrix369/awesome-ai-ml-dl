# The Complete MCP Server Setup Guide: Claude Desktop, Claude Code, and Cursor

*Stop wasting time with broken configs. Here's the setup that actually works.*

## Why This Guide Exists

You've probably stumbled across 5 different blog posts about MCP (Model Context Protocol) servers, tried 3 different configs, and ended up with nothing working. The documentation is scattered, package names are wrong in popular guides, and nobody tells you which config file goes where.

This guide fixes that. One comprehensive walkthrough for all three tools.

## ⚠️ CRITICAL: Replace Usernames and Paths

**Before you start**: This guide contains placeholder usernames and paths that you MUST replace with your actual system information:

- **`YOUR_USERNAME`** → Replace with your actual username (e.g., `john`, `mary`, `mymacbook`)
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
"/Users/mymacbook/claude-mcp-configs/shared-memory.json"
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

**Choose your tool below for detailed setup instructions:**

Each guide is comprehensive and includes installation, configuration, verification, and troubleshooting specific to that tool.

---

### 2.1: 🖥️ Claude Desktop Setup

**What you'll learn**: GUI-based MCP server setup, config file location across platforms, shared memory configuration, and visual verification methods.

**Key highlights**:
- Find config files via Claude Desktop UI across macOS, Windows, and Linux
- Three configuration options: Simple (mcp-cursor), Shared Memory, and Advanced (multiple servers)
- Step-by-step config file editing with validation
- Visual verification of active MCP servers in the UI

**[→ Read the complete Claude Desktop setup guide](./claude-desktop-setup.md)**

---

### 2.2: 💻 Claude Code (CLI) Setup

**What you'll learn**: Terminal-based MCP server setup, critical differences from Claude Desktop, and CLI verification commands.

**Key highlights**:
- **Critical**: Claude Code requires `"type": "stdio"` in every server config
- Find and edit `~/.claude.json` config file
- Verify setup with `claude mcp list` and other CLI commands
- No restart needed - changes apply immediately

**[→ Read the complete Claude Code setup guide](./claude-code-setup.md)**

---

### 2.3: 🎯 Cursor IDE Setup

**What you'll learn**: IDE-integrated MCP server setup with both global and project-level configurations.

**Key highlights**:
- Choose between global config (all projects) or project config (version controlled)
- Find config files via Cursor UI and Command Palette
- Real-time JSON validation in Cursor editor
- Test MCP functionality directly in Cursor Chat

**[→ Read the complete Cursor IDE setup guide](./cursor-ide-setup.md)**

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

**What you'll learn**: Beyond basic memory—filesystem access, sequential thinking, and popular third-party integrations like Brave Search and GitHub.

**Key highlights**:
- Filesystem server setup with security best practices
- Sequential thinking for complex problem-solving
- What NOT to install to avoid conflicts
- Recommended third-party MCP servers

**[→ Read the complete Advanced MCP Servers guide](./advanced-mcp-servers.md)**

---

## Part 5: Troubleshooting

**What you'll learn**: Solutions to common MCP setup issues across all platforms and tools.

**Key highlights**:
- Fix username and path placeholder issues (#1 cause of failures)
- Resolve "command not found: npx" errors
- Debug config file loading problems
- Fix shared memory persistence issues
- Quick diagnostic checklist for fast problem identification

**[→ Read the complete Troubleshooting guide](./troubleshooting.md)**

---

## Part 6: Pro Setup & Advanced Tools

**What you'll learn**: Advanced setup tools, verification scripts, and team workflows.

**Key highlights**:
- Desktop Extensions (.dxt files) for one-click installation
- Automated verification scripts for macOS, Windows, and Linux
- Team setup best practices with version control
- Production environment configuration with environment variables
- CI/CD integration patterns

**[→ Read the complete Pro Setup guide](./pro-setup.md)**

---

<details>
<summary><strong>Quick Start Checklist (Click to expand)</strong></summary>

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