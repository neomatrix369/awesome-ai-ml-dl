# AI Agents

This document outlines key concepts and components related to building AI agents.

## APIs

Application Programming Interfaces (APIs) are crucial for AI agents to interact with external services and data sources. Some popular APIs and libraries used in AI agent development include:

*   **Ollama:** Allows running large language models (LLMs) locally. This is beneficial for privacy, offline capabilities, and cost savings.
*   **LiteLLM:** Provides a unified interface to interact with various LLM APIs (e.g., OpenAI, Cohere, Anthropic). This simplifies switching between different models and providers.

## Context and Instructions

Providing clear and concise context and instructions is vital for an AI agent to perform tasks accurately and efficiently.

*   **Context:** This includes relevant background information, data, and previous interactions that the agent needs to understand the current task.
*   **Instructions:** These are specific commands or guidelines that tell the agent what to do, how to do it, and what constraints to follow. Well-defined instructions help in guiding the agent's behavior and ensuring desired outcomes.

## Tool Calls

Tool calls enable AI agents to extend their capabilities by interacting with external tools and functions.

*   **Function Calling:** LLMs can be instructed to call predefined functions or tools to perform specific actions, such as retrieving information from a database, calling an external API, or executing a piece of code.
*   **Output Parsing:** The agent needs to be able to parse the output from tool calls and integrate the results back into its workflow.

## MCP (Model-View-Controller-Presenter)

While not a direct acronym, the concepts from software architecture patterns like Model-View-Controller (MVC) and Model-View-Presenter (MVP) can be adapted for structuring AI agents.

*   **Model:** Represents the agent's knowledge, data, and the underlying LLM.
*   **View:** Handles the interaction with the user or other systems (e.g., displaying information, receiving input).
*   **Controller/Presenter:** Manages the flow of information and logic between the Model and the View. It interprets user input, invokes tools, updates the model, and determines what to present to the user. This helps in separating concerns and making the agent more modular and maintainable.

## Pydantic

Pydantic is a Python library for data validation and settings management using Python type hints. It is highly useful in AI agent development for:

*   **Data Validation:** Ensuring that data passed to and from LLMs, tools, and APIs conforms to expected schemas.
*   **Structured Output:** Defining clear and validated output structures for LLM responses, making it easier to parse and use the generated information reliably.
*   **Configuration Management:** Managing agent configurations and settings in a type-safe manner.

## MCP Integration with SSE and Stdio

Integrating MCP-based agents with various communication channels enhances their interactivity and usability.

*   **Server-Sent Events (SSE):** SSE is a web technology that allows a server to send real-time updates to a client over a single HTTP connection. For AI agents, this means the "View" can be a web interface that receives continuous updates from the agent (e.g., streaming responses, status updates) managed by the "Controller/Presenter". This is useful for long-running tasks or when providing incremental feedback to the user.
*   **Standard Input/Output (stdio):** For command-line interface (CLI) based agents, the "View" interacts with the user via stdio. The "Controller/Presenter" processes text input and sends text output back to the terminal. This is a straightforward way to interact with agents for local development, scripting, or integration with other CLI tools.

## Anonymous Agents and Feedback Loops

Developing robust AI agents often involves iterative improvement based on user interactions and feedback.

*   **Anonymous Agents:** These are agents that interact with users without revealing their underlying identity or specific model. This can be useful for collecting unbiased feedback or for A/B testing different agent versions.
*   **Feedback Loops:** Implementing mechanisms to capture explicit and implicit feedback from users is crucial.
    *   **Explicit Feedback:** Users directly providing ratings, corrections, or suggestions.
    *   **Implicit Feedback:** Analyzing user behavior, such as task completion rates, clarifications requested, or abandonment of interactions.
    This feedback is then used to refine the agent's "Model" (e.g., fine-tuning the LLM, updating knowledge bases) or its "Controller/Presenter" logic (e.g., improving instruction interpretation, tool selection).

## Agentic AI

Agentic AI refers to systems that can operate autonomously to achieve goals, make decisions, and take actions in an environment. Key characteristics include:

*   **Goal-oriented:** Agents are designed with specific objectives to achieve.
*   **Autonomous:** They can operate without constant human intervention.
*   **Perception:** They can perceive their environment through sensors or data inputs.
*   **Action:** They can take actions that affect their environment or internal state.
*   **Learning/Adaptation:** Many agentic systems can learn from experience and adapt their behavior over time. This often involves complex reasoning, planning, and memory capabilities.

## Tools and Frameworks for Building AI Agents

Several tools and frameworks have emerged to simplify the development of AI agents:

*   **Langchain:** An open-source framework for building applications with LLMs. It provides modules for managing prompts, memory, chains (sequences of calls), indexes, and agents.
*   **CrewAI:** A framework for orchestrating role-playing, autonomous AI agents. It helps in creating collaborative AI crews that can work together on complex tasks.
*   **Langsmith:** A platform by Langchain for debugging, testing, evaluating, and monitoring LLM applications. It provides visibility into agent behavior and helps in identifying areas for improvement.
*   **Google A2A (Agents for Automation):** While specific public details might vary, Google has research and products focused on AI agents for automating tasks and processes.
*   **Google GenAI (Generative AI):** Google offers a suite of Generative AI tools and models (e.g., Gemini) that can be the core "Model" component of AI agents, providing powerful language understanding and generation capabilities. This includes Vertex AI for building and deploying AI models.
*   **Other tools:** Many other specialized tools exist for aspects like vector databases (e.g., Pinecone, Weaviate) for semantic search, workflow orchestration (e.g., Apache Airflow with AI plugins), and more.

## Bary's MCP Headless Gmail Server

A specific example of an MCP (Model Context Protocol) server is Bary Huang's `mcp-headless-gmail`. This server allows AI agents to interact with Gmail for tasks like reading and sending emails without requiring local credential or token setup directly on the machine running the agent.

**Project Repository:** [https://github.com/baryhuang/mcp-headless-gmail](https://github.com/baryhuang/mcp-headless-gmail)

### Key Features and Advantages

*   **Headless and Remote Operation:** Designed to run in environments like Docker containers or remote servers where direct browser access for OAuth is not feasible. This is a significant advantage over solutions requiring local file access.
*   **Decoupled Architecture:** The client application (e.g., an AI agent or a tool like Claude Desktop) handles the Google OAuth 2.0 flow independently. The obtained credentials (access token, refresh token, client ID, client secret) are then passed as context to this MCP server with each request. This separates credential management from the server's email processing logic.
*   **Gmail Focused:** Primarily provides tools for Gmail, making it a lightweight solution if only email capabilities are needed (e.g., for marketing automation agents).
*   **Docker-Ready:** Provides a Dockerfile for easy containerization and deployment.
*   **Core Functionality:**
    *   Get recent emails (with the first 1k characters of the body).
    *   Get full email body content (in 1k chunks using an offset).
    *   Send emails.
    *   Refresh access tokens using a dedicated tool.
    *   Automatic refresh token handling by the underlying Google API client.

### Prerequisites

*   Python 3.10 or higher for running the server directly.
*   Google API Credentials:
    *   Client ID
    *   Client Secret
    *   Access Token
    *   Refresh Token
    To obtain these, you need to set up a project in the Google Cloud Console, enable the Gmail API, configure the OAuth consent screen, and create OAuth 2.0 client ID credentials (typically for "Desktop app" or "Web application" depending on your client).
    *   **Required Scopes:**
        *   `https://www.googleapis.com/auth/gmail.readonly` (for reading emails)
        *   `https://www.googleapis.com/auth/gmail.send` (for sending emails)

### Installation and Setup

There are two main ways to use the server:

1.  **Running with Python (Local Development/Custom Setup):**
    ```bash
    git clone https://github.com/baryhuang/mcp-headless-gmail.git
    cd mcp-headless-gmail
    pip install -e .
    # Start the server
    mcp-server-headless-gmail
    ```

2.  **Running with Docker (Recommended for Production/Isolation):**
    *   **Build the image:**
        ```bash
        docker build -t mcp-headless-gmail .
        ```
    *   Or use the pre-built image: `buryhuang/mcp-headless-gmail:latest`
    *   **Run the container:**
        The server within the Docker container listens for MCP requests typically via stdio.

### Integration Guide (MCP Client Configuration)

The `mcp-headless-gmail` server is designed to be called by an MCP client. The client needs to be configured to invoke this server for Gmail-related tools.

**Example Configuration (Conceptual - e.g., for a client like Claude Desktop):**

The client configuration tells it how to start and communicate with the MCP server.

*   **Using Docker:**
    ```json
    {
      "mcpServers": {
        "gmail": {
          "command": "docker",
          "args": [
            "run",
            "-i",         // Interactive, keep STDIN open
            "--rm",       // Automatically remove the container when it exits
            "buryhuang/mcp-headless-gmail:latest"
          ]
        }
      }
    }
    ```

*   **Using `npx` (for the npm package wrapper, if available):**
    ```json
    {
      "mcpServers": {
        "gmail": {
          "command": "npx",
          "args": [
            "@peakmojo/mcp-server-headless-gmail"
          ]
        }
      }
    }
    ```

**Tool Call Structure:**

When the AI agent needs to use a Gmail tool, it will make a request structured for the MCP server. Crucially, Google API credentials must be passed in the tool call context because the server itself is stateless and doesn't store them.

1.  **Refreshing Tokens (`gmail_refresh_token` tool):**
    This should be the first step or used when an access token expires.
    *   **Input (with existing access and refresh tokens):**
        ```json
        {
          "google_access_token": "your_access_token",
          "google_refresh_token": "your_refresh_token",
          "google_client_id": "your_client_id",
          "google_client_secret": "your_client_secret"
        }
        ```
    *   **Input (if access token expired, using only refresh token):**
        ```json
        {
          "google_refresh_token": "your_refresh_token",
          "google_client_id": "your_client_id",
          "google_client_secret": "your_client_secret"
        }
        ```
    *   **Output:** Will include a new `access_token` and its `expiry_time`.

2.  **Getting Recent Emails (`gmail_get_recent_emails` tool):**
    *   **Input:**
        ```json
        {
          "google_access_token": "current_valid_access_token",
          "max_results": 5,
          "unread_only": false
        }
        ```
    *   **Output:** List of emails with metadata and the first 1k characters of the body.

3.  **Getting Full Email Body Content (`gmail_get_email_content` tool):**
    Used when an email body is >1k characters.
    *   **Input:**
        ```json
        {
          "google_access_token": "current_valid_access_token",
          "message_id": "message_id_from_get_recent_emails", // or "thread_id"
          "offset": 0 // increment by 1000 for subsequent chunks
        }
        ```
    *   **Output:** Chunk of the email body. Repeat with increasing offset until `contains_full_body` is true.

4.  **Sending an Email (`gmail_send_email` tool):**
    *   **Input:**
        ```json
        {
          "google_access_token": "current_valid_access_token",
          "to": "recipient@example.com",
          "subject": "Hello from MCP Agent",
          "body": "This is the plain text body.",
          "html_body": "<p>This is the <strong>HTML</strong> body.</p>"
        }
        ```

### Security Considerations

*   **Credential Handling:** The primary security benefit is that the `mcp-headless-gmail` server itself does not store your Google credentials long-term. They are passed with each request (or at least the access token is).
*   **Client Responsibility:** The client application (your AI agent, Claude Desktop, etc.) is responsible for securely obtaining, storing, and managing the Google OAuth credentials (especially the refresh token).
*   **Secure Communication:** Ensure that the communication channel between your AI agent and the `mcp-headless-gmail` server is secure if they are running on different machines or in potentially insecure environments.

This server provides a valuable component for AI agents needing to interact with Gmail in a secure and flexible manner, especially in automated or headless setups. By conforming to the MCP, it can be integrated into various agent frameworks and client applications.

## Additional Resources

- For a curated list of MCP frameworks, tutorials, and tools relevant to AI agent development, please see our [MCPs, Tutorials, and Tools list](./resources/mcp-tutorials-tools.md).
