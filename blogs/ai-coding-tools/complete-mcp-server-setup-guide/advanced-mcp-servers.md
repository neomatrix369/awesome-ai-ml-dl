# 🚀 Advanced MCP Servers

[Home](../../../../README.md) · [✍️ AI Coding Tools](../../README.md) · [🔧 Complete MCP Guide](./post.md)

#advanced-mcp-servers · [← Back home](../../../README.md) · [← Back to blogs](../README.md)

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

## Sequential Thinking

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

## Advanced Reasoning

**When**: Enhanced problem-solving with confidence tracking, meta-cognitive reflection, and hypothesis testing.

**What it provides**:
- Confidence scoring (0.0-1.0 scale) for reasoning quality
- Meta-cognitive reflection capabilities
- Hypothesis formulation and testing
- Named reasoning contexts (memory libraries) for different projects
- JSON-serializable workflow storage

**Installation**:
```bash
git clone https://github.com/angrysky56/advanced-reasoning-mcp.git
cd advanced-reasoning-mcp
npm install
npm run build
```

**Config** (add to existing `mcpServers`):
```json
"advanced-reasoning": {
  "command": "node",
  "args": ["/absolute/path/to/advanced-reasoning-mcp/build/index.js"]
}
```

**Note for Claude Code**: Add `"type": "stdio"`:
```json
"advanced-reasoning": {
  "command": "node",
  "args": ["/absolute/path/to/advanced-reasoning-mcp/build/index.js"],
  "type": "stdio"
}
```

**Usage**:
- Main tool: `advanced_reasoning` for enhanced reasoning with cognitive features
- Create memory libraries: `create_memory_library` for separate reasoning contexts
- Store workflows: `create_system_json` for reusable JSON workflows

**Platform Paths**:
| OS | Example Path |
|----|--------------|
| **macOS** | `/Users/YOUR_USERNAME/advanced-reasoning-mcp/build/index.js` |
| **Windows** | `C:\Users\YOUR_USERNAME\advanced-reasoning-mcp\build\index.js` |
| **Linux** | `/home/YOUR_USERNAME/advanced-reasoning-mcp/build/index.js` |

---

## Thinking Patterns

**When**: Structured reasoning across systematic thinking, mental models, scientific analysis, and collaborative problem-solving.

**What it provides**:
- Sequential planning and problem decomposition
- Decision frameworks and domain modeling
- Hypothesis testing and critical evaluation
- Multi-perspective problem-solving
- Visual reasoning and temporal modeling
- Stochastic algorithms for uncertainty handling

**Installation**:
```bash
npm install -g @emmahyde/thinking-patterns
```

**Config** (add to existing `mcpServers`):
```json
"thinking-patterns": {
  "command": "npx",
  "args": ["-y", "@emmahyde/thinking-patterns"]
}
```

**Note for Claude Code**: Add `"type": "stdio"`:
```json
"thinking-patterns": {
  "command": "npx",
  "args": ["-y", "@emmahyde/thinking-patterns"],
  "type": "stdio"
}
```

**Alternative Installation (Cursor with Smithery)**:
```bash
npx -y @smithery/cli install @emmahyde/thinking-patterns --client cursor
```

**Usage**: The server enforces structural consistency through interactive schema validation across six reasoning categories:
- Systematic Thinking
- Mental Models
- Scientific Analysis
- Collaborative Reasoning
- Advanced Cognitive Patterns
- Probabilistic Optimization

---

## Graphiti Memory

**When**: You need a temporal knowledge graph for evolving user interactions and cross-session memory persistence.

**What it provides**:
- Temporal knowledge graph with historical metadata
- Custom entity definitions (Requirements, Preferences, Procedures)
- Cross-session memory persistence
- Real-time graph updates
- Structured data storage with Pydantic models

**Requirements**:
- Python environment (managed via `uv`)
- Database: FalkorDB (default) or Neo4j
- API keys for LLM provider (OpenAI, Anthropic, Gemini, or Groq)

**Installation**:
```bash
# Clone repository
git clone https://github.com/getzep/graphiti.git
cd graphiti/mcp_server

# Install uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
uv sync

# Optional: Install additional LLM providers
uv sync --extra providers
```

**Environment Setup**:

Create `.env` file or copy the `.env.example` to `.env` in `mcp_server/` directory:
```bash
# Required: Choose your LLM provider
OPENAI_API_KEY=your-openai-key
# OR
ANTHROPIC_API_KEY=your-anthropic-key
# OR
GOOGLE_API_KEY=your-gemini-key
# OR
GROQ_API_KEY=your-groq-key

# Optional: Azure OpenAI
AZURE_OPENAI_API_KEY=your-azure-key
AZURE_OPENAI_ENDPOINT=your-azure-endpoint
AZURE_OPENAI_DEPLOYMENT=your-deployment-name

# Optional: Neo4j (if not using FalkorDB)
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your-password

# Optional: Concurrency control
SEMAPHORE_LIMIT=10
```

**Start Database**:
```bash
# From mcp_server/ directory
docker compose up  # FalkorDB (default)

# OR for Neo4j
docker compose -f docker/docker-compose-neo4j.yml up
```

**Config for MCP Client**:

**Note**: Graphiti uses HTTP transport, not stdio. The MCP server runs at `http://localhost:8000/mcp/`

For Claude Code/Claude Desktop/Cursor (HTTP connection):
```json
"graphiti-memory": {
  "type": "stdio",
  "command": "npx",
  "args": [
    "mcp-remote",
    "http://127.0.0.1:8000/mcp/"
  ]
}
```

**Platform-Specific Paths**:
| OS | Clone Location Example |
|----|------------------------|
| **macOS** | `/Users/YOUR_USERNAME/graphiti/mcp_server` |
| **Windows** | `C:\Users\YOUR_USERNAME\graphiti\mcp_server` |
| **Linux** | `/home/YOUR_USERNAME/graphiti/mcp_server` |

**Usage**:
- Query Graphiti before taking actions
- Add and update entities in the knowledge graph
- Define custom entities for your domain (Requirements, Preferences, etc.)
- Memory persists across sessions automatically

**Important Notes**:
- Adjust `SEMAPHORE_LIMIT` based on your LLM provider's rate limits
- Database must be running before starting the MCP server
- Use `.env` file for API keys (never commit to version control)

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
