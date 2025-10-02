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
