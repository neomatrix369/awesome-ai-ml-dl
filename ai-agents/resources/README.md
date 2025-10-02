# MCP Frameworks, Tutorials, and Tools for AI Agent Development

This document provides a curated list of Model-Control-Presenter (MCP) frameworks, tutorials, tools, and platforms relevant to the development of AI agents.

## MCP Frameworks

*   **[Langchain](https://www.langchain.com/)**: A comprehensive framework for developing applications powered by language models. It provides modular components for working with LLMs, including models, prompts, memory, indexes, chains, and agents, which align well with MCP concepts.
*   **[CrewAI](https://www.crewai.com/)**: A framework for orchestrating role-playing, autonomous AI agents. CrewAI enables agents to collaborate to solve complex tasks, fitting an advanced MCP paradigm where multiple controller/presenter layers interact.
*   **[Microsoft Autogen](https://microsoft.github.io/autogen/)**: A framework for enabling next-generation LLM applications with multi-agent conversations. Autogen allows developers to build complex workflows with multiple agents that can converse with each other and humans, embodying a distributed MCP architecture.
*   **[Uagents](https://fetch.ai/docs/uea/framework/uagents/)**: A framework by Fetch.ai for building decentralized autonomous agents. It allows for the creation of agents that can perform tasks, communicate, and transact in a decentralized network.
*   **[Fast-Agent](https://github.com/HumanAIGC/fastagent)**: An experimental framework for building autonomous agents with minimal code, often leveraging LLMs for decision-making and tool use. (Note: This appears to be one of several projects with similar names; link is to a prominent one.)

## Awesome Lists

*   [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers): A curated list of awesome Model Context Protocol (MCP) servers.
*   [awesome-mcp-devtools](https://github.com/punkpeye/awesome-mcp-devtools): A curated list of awesome MCP developer tools, libraries, and utilities.
*   [awesome-mcp-clients](https://github.com/punkpeye/awesome-mcp-clients): A curated list of awesome MCP clients and client libraries.

## MCP Servers

This section highlights specific open-source MCP server and client implementations, many from Bary Huang and PeakMojo, showcasing practical applications of the MCP concept for enabling AI agents to interact with various external services and systems. It also includes conceptual examples of how MCP servers can be built using different technologies.

*   **[agentic-mcp-client (PeakMojo)](https://github.com/peakmojo/agentic-mcp-client)**: A standalone agent runner that executes tasks using MCP tools via Anthropic Claude, AWS Bedrock, and OpenAI APIs. Enables autonomous agent operation in cloud environments.
*   **[voice-mcp-client (Bary Huang)](https://github.com/baryhuang/voice-mcp-client)**: An iOS/MacOS Swift MCP client using voice to interact with Python MCP servers natively.
*   **[mcp-remote-macos-use (Bary Huang)](https://github.com/baryhuang/mcp-remote-macos-use)**: An MCP server enabling AI to control remote macOS systems (screen sharing, keyboard/mouse input) for interaction with any macOS application.
*   **[mcp-hubspot (PeakMojo/Bary Huang)](https://github.com/peakmojo/mcp-hubspot)**: MCP server for HubSpot CRM integration, allowing AI models to interact with HubSpot data. Features vector storage and caching.
*   **[mcp-headless-gmail (Bary Huang)](https://github.com/baryhuang/mcp-headless-gmail)**: An MCP server for headless Gmail integration, enabling AI assistants to read, search, and send emails without direct local credential setup. (Also detailed in the main `ai-agents/README.md`).
*   **[mcp-server-zoom-noauth (PeakMojo)](https://github.com/peakmojo/mcp-server-zoom-noauth)**: An MCP server for accessing Zoom recordings and transcripts without requiring direct end-user authentication.
*   **[my-apple-remembers (Bary Huang)](https://github.com/baryhuang/my-apple-remembers)**: MCP server for reading and managing Apple Notes on macOS.
*   **[mcp-server-any-openapi (Bary Huang)](https://github.com/baryhuang/mcp-server-any-openapi)**: An MCP server that allows AI to discover and call any API endpoint via semantic search on OpenAPI specifications.
*   **[mcp-server-aws-resources-python (Bary Huang)](https://github.com/baryhuang/mcp-server-aws-resources-python)**: MCP server for AWS resource management using Python's boto3.
*   **`mcp-bridge` and `mcp-bridge-compose`**: These tools, presumably related to Bary Huang's MCP work, are not found as public standalone repositories. They might be internal utilities, integrated into other projects, or examples for using MCP servers with Docker Compose.
*   **Conceptual MCP Server Examples**: The MCP pattern can be implemented in various languages and frameworks. Below are conceptual examples of how such servers might be named or built. Specific public repositories for these exact names by Bary Huang or PeakMojo were not found, so these serve as illustrative patterns:
    *   `mcp-server-python-flask`: An MCP server built with Python and the Flask web framework.
    *   `mcp-server-go-grpc`: An MCP server built with Go, using gRPC for communication.
    *   `mcp-server-java-spring`: An MCP server built with Java and the Spring Boot framework.
    *   `mcp-server-node-express`: An MCP server built with Node.js and the Express.js framework.

## Tutorials

*   **[Langchain Quickstart](https://python.langchain.com/docs/get_started/quickstart)**: The official quickstart guide for Langchain, providing a hands-on introduction to its core concepts and how to build your first LLM application.
*   **[CrewAI Quickstart](https://docs.crewai.com/quickstart/)**: Official CrewAI documentation to quickly get started building multi-agent collaborative systems.
*   **[Microsoft Autogen Examples](https://microsoft.github.io/autogen/docs/Examples/AutoGen-Agent)**: A collection of examples showcasing how to use Autogen for various multi-agent scenarios.
*   **[Build Your First AI Agent with Uagents](https://fetch.ai/docs/uea/guides/general/intro-to-uagent-course/build-your-first-uagent/)**: A step-by-step guide to creating your first agent using the Fetch.ai Uagents framework.
*   **[Introduction to Agents with Haystack](https://haystack.deepset.ai/tutorials/23_introducing_agents)**: A tutorial by deepset Haystack on how to build and use agents for question answering and task execution.
*   **[Creating a Simple AI Agent with LiteLLM](https://docs.litellm.ai/docs/simple_proxy#example-usage-1)**: Demonstrates basic LiteLLM proxy usage, a step towards agent tool calling by abstracting LLM provider interactions.

## Communities

### Hackathons and Events

*   Luma
*   KXSB
*   Agentic Foundation
*   Google Labs Discord
*   Programmers Hangout
*   AI Native Developer
*   Various LinkedIn groups focused on AI and agent development.

## Tools (General Purpose for Agent Development)

*   **[LiteLLM](https://litellm.ai/)**: Provides a unified interface to interact with various LLM APIs (OpenAI, Cohere, Anthropic, etc.). Essential for the "Model" component in an MCP architecture, allowing flexibility.
*   **[Ollama](https://ollama.com/)**: Allows running large language models (LLMs) locally. Useful for developing and testing agents with local models, ensuring privacy and reducing costs.
*   **[LangSmith](https://www.langchain.com/langsmith)**: A platform by Langchain for debugging, testing, evaluating, and monitoring LLM applications. Crucial for understanding and improving agent behavior.
*   **[Pydantic](https://pydantic-docs.helpmanual.io/)**: A Python library for data validation and settings management using Python type hints. Extremely useful for defining schemas for tool inputs/outputs and agent configurations.
*   **[FastAPI](https://fastapi.tiangolo.com/)**: A modern, fast web framework for building APIs with Python. Often used to expose agent capabilities as services.
*   **[Chainlit](https://chainlit.io/)**: An open-source Python package that makes it incredibly fast to build and share AI user interfaces. Can serve as the "View" component.
*   **[Gradio](https://www.gradio.app/)**: A Python library that allows you to quickly create customizable UI components for your machine learning models. Useful for creating interactive "Views".
*   **[OpenWebUI](https://openwebui.com/)**: An extensible, self-hosted AI interface that supports various LLMs and operates offline. Can serve as a user-facing "View" for interacting with agents. (GitHub: [open-webui/open-webui](https://github.com/open-webui/open-webui))
*   **[Vector Databases (e.g., Pinecone, Weaviate, Chroma)](https://www.pinecone.io/)**: Tools for storing and searching vector embeddings, critical for agents needing to retrieve information from large knowledge bases.
*   **[Hugging Face Transformers](https://huggingface.co/docs/transformers/index)**: Provides thousands of pre-trained models and tools to access them. Excellent for sourcing open-source models for the "Model" part of an agent.
*   **[Flowise AI](https://flowiseai.com/)**: A low-code/no-code tool for building LLM applications, including agents, using a visual interface.
*   **[Embedchain](https://embedchain.ai/)**: A framework that simplifies creating and managing LLM-powered bots over any dataset. It handles loading, chunking, embedding, and storing data, facilitating the "Model" or knowledge retrieval aspect for agents.
*   **[Claude Desktop](https://www.anthropic.com/claude#claude-app)**: A desktop application by Anthropic for interacting with their Claude AI models. While a product, it can be used as a "View" or testbed for agentic interactions if the underlying model supports tool use.
*   **AgentSpace, Jules, Cline, Roo Code**: These tools are either not widely known public projects in the AI agent development space, specific internal tools, or may refer to more generic concepts. Specific public links for AI agent frameworks/tools with these names were not readily identifiable.

## Platforms and Cloud Services

*   **[OpenAI API](https://platform.openai.com/docs/api-reference)**: Direct access to OpenAI models like GPT-4, GPT-3.5-turbo, which are often the "Model" component in many AI agents.
*   **[Google AI Studio & Vertex AI](https://cloud.google.com/vertex-ai/docs/generative-ai/ai-studio/overview)**: Google Cloud's platform for building, deploying, and managing ML models, including generative AI models like Gemini. Provides infrastructure and tools for the "Model" and agent deployment.
*   **[Google BigQuery](https://cloud.google.com/bigquery)**: A highly scalable, serverless data warehouse. Often used as a backend for storing and analyzing data used by AI agents or generated from their operations.

This list is not exhaustive but provides a good starting point for developers looking to build AI agents using MCP principles.
The field is rapidly evolving, so it's recommended to also follow communities and publications in the AI space for the latest developments.
