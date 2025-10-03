# The Complete MCP Server Setup Guide: Claude Desktop, Claude Code, and Cursor

*Stop wasting time with broken configs. Here's the setup that actually works.*

## Why This Guide Exists

You've probably stumbled across 5 different blog posts about MCP (Model Context Protocol) servers, tried 3 different configs, and ended up with nothing working. The documentation is scattered, package names are wrong in popular guides, and nobody tells you which config file goes where.

This guide fixes that. One comprehensive walkthrough for all three tools.

## ⚠️ CRITICAL: Replace Usernames and Paths

**Before you start**: Replace all placeholders with your actual system information:
- **`YOUR_USERNAME`** → Your actual username (run `whoami`)
- **`/path/to/allowed/directory`** → Actual directory paths

**Example:**
```json
// ❌ WRONG
"/Users/YOUR_USERNAME/claude-mcp-configs/shared-memory.json"

// ✅ CORRECT
"/Users/john/claude-mcp-configs/shared-memory.json"
```

## Quick Reference: Which Tool When?

Before we dive into setup, understand what you're installing:

| Tool | Best For | Interface | Config Location |
|------|----------|-----------|-----------------|
| **Claude Desktop** | GUI workflows, exploring projects | Desktop app | `~/Library/Application Support/Claude/claude_desktop_config.json` (Mac) |
| **Claude Code** | Terminal workflows, CI/CD, scripting | CLI | `~/.claude.json` |
| **Cursor IDE** | Full IDE experience, VS Code users | Desktop IDE | `.cursor/mcp.json` (project) or global settings |

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

**After setting up Option 2 (Shared Memory):**

### Test Memory Across Tools

1. **Store info in one tool**: In Claude Desktop, ask "Remember my project is AcmeApp with React"
2. **Retrieve in other tools**: Ask "What's my project name?" in Claude Code and Cursor
3. **Verify all tools return**: "Your project is AcmeApp with React"

### Verification

**Check servers are active:**
- **Claude Desktop**: Look for MCP indicator in UI
- **Claude Code**: Run `claude mcp list`
- **Cursor**: Settings → MCP (should show green status)

**Troubleshooting:**
- Verify identical memory file paths across all tools
- Check for `YOUR_USERNAME` placeholders
- Restart applications after config changes

✅ **Success**: All tools remember the same information

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