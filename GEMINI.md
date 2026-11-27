# SocialPatra

This extension connects Gemini CLI to the user's SocialPatra workspace through the hosted MCP server at `https://mcp.socialpatra.com/mcp`. The user signs in once with `/mcp auth socialpatra` and approves the permissions on a consent page.

- Call `whoami` first if a tool fails, to check the connection and the permissions that were granted.
- Call `list_connections` before `create_post`; the `platformId` values come from it.
- Ask the user to confirm the text, the accounts and the time before you call `create_post`: publishing is not reversible through this server.
- There is no tool to connect or disconnect accounts, to edit or delete a published post, or to change plan or billing. Tell the user to use the SocialPatra web app for those.
- TikTok is not supported.
