# Advanced MCP Servers

**[← Back to Main Guide](./post.md)**

## Overview

Beyond basic memory and filesystem access, MCP offers specialized servers for advanced capabilities like sequential thinking, web search, and third-party integrations.

---

## Filesystem Access

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
    "/path/to/allowed/directory3"
  ]
}
```

**Security**: Only grant access to directories you trust.

**Note for Claude Code**: Add `"type": "stdio"` to the config:
```json
"filesystem": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-filesystem",
    "/path/to/allowed/directory"
  ],
  "type": "stdio"
}
```

---

## Sequential Thinking (Advanced Reasoning)

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

**Note for Claude Code**: Add `"type": "stdio"`:
```json
"sequential-thinking": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
  "type": "stdio"
}
```

**Usage**: In any tool, ask "Use sequential thinking to break down this problem..."

---

## What NOT to Install

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

## Common Advanced Server Additions

### Brave Search MCP (Web Search)

**When**: You need real-time web search capabilities

**Installation**: Follow [Brave Search MCP documentation](https://github.com/modelcontextprotocol/servers/tree/main/src/brave-search)

**Config example**:
```json
"brave-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-brave-search"],
  "env": {
    "BRAVE_API_KEY": "your-api-key-here"
  }
}
```

### GitHub MCP (Repository Integration)

**When**: You need direct GitHub repository access

**Installation**: Follow [GitHub MCP documentation](https://github.com/modelcontextprotocol/servers/tree/main/src/github)

**Config example**:
```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_TOKEN": "your-github-token"
  }
}
```

### Linear/Sentry MCP (Project Management)

**When**: You need integration with project management tools

Check the [MCP Server Registry](https://github.com/modelcontextprotocol/servers) for available integrations.

---

## Best Practices

1. **Start Simple**: Begin with memory or mcp-cursor, then add capabilities as needed
2. **Avoid Duplication**: Don't run multiple servers that provide the same functionality
3. **Secure Paths**: Only grant filesystem access to necessary directories
4. **Use Environment Variables**: Store API keys in environment variables, not in config files
5. **Version Control**: Don't commit sensitive config files with API keys

---

## Testing Advanced Servers

After installing any advanced server:

1. **Restart your application** (Claude Desktop, Claude Code, or Cursor)
2. **Verify server status**: Check that it appears in the MCP tools list
3. **Test functionality**: Try a simple command specific to that server
4. **Check logs**: If issues arise, check the server logs for errors

---

**[← Back to Main Guide](./post.md)** | **[← Previous: Cursor IDE Setup](./cursor-ide-setup.md)** | **[Next: Troubleshooting →](./troubleshooting.md)**
