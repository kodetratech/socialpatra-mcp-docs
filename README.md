# SocialPatra MCP server

SocialPatra is a social media scheduler that charges per connected account. Its hosted MCP server lets an AI assistant list your connected accounts, draft, publish or schedule posts, check post status, read analytics and use your content library, inside the one workspace you approve.

This repository holds public documentation only. The server software is proprietary and is not published here.

## Server URL

```
https://mcp.socialpatra.com/mcp
```

Remote server, streamable HTTP, OAuth 2.1 with PKCE and dynamic client registration. No API key and no install are needed. A paid SocialPatra plan is required (see [Plans and limits](#plans-and-limits)).

## Connect in 2 minutes

Each client signs you in to SocialPatra in your browser. You pick the workspace and approve the permissions on a consent page. Sources for each client's steps are the client vendors' own documentation.

### Claude apps (web and desktop)

1. Go to **Customize > Connectors**, click **+ Add**, then **Add custom connector**.
2. Name it `SocialPatra` and enter `https://mcp.socialpatra.com/mcp` as the URL.
3. Leave the OAuth client on automatic registration, finish adding it, then sign in to SocialPatra when asked.
4. In a chat, click **+**, choose **Connectors**, and turn SocialPatra on.

On Team and Enterprise plans an organization owner adds the connector first under **Organization settings > Connectors**. Claude limits the free plan to one custom connector.

### Claude Code

```
claude mcp add --transport http socialpatra https://mcp.socialpatra.com/mcp
```

Then run `/mcp` inside Claude Code, pick `socialpatra`, and follow the browser sign-in.

### ChatGPT

On the web, open ChatGPT Plugins, choose the plus button, then **Add custom MCP server**. Enter the URL above, choose OAuth for authentication, confirm the risk warning, create it as a plugin and install it. Which ChatGPT plans can add custom servers is decided by OpenAI and has changed over time, so check your plan.

### Cursor

Add this to `~/.cursor/mcp.json` (or `.cursor/mcp.json` in a project), then select **Connect** when Cursor lists the server:

```json
{
  "mcpServers": {
    "socialpatra": {
      "url": "https://mcp.socialpatra.com/mcp"
    }
  }
}
```

### Gemini CLI

```
gemini mcp add --transport http socialpatra https://mcp.socialpatra.com/mcp
```

Then run `/mcp auth socialpatra` inside Gemini CLI. The sign-in needs a local browser.

### OpenAI Codex CLI

```
codex mcp add socialpatra --url https://mcp.socialpatra.com/mcp
codex mcp login socialpatra
```

Use `--no-browser` on the login command if your terminal has no local browser.

### Check it works

Ask: "Use SocialPatra: who am I?" The assistant calls `whoami` and shows your workspace and the permissions you granted.

## What you can ask it to do

- "List the social accounts connected to my SocialPatra workspace."
- "Check whether any of my connected accounts need to be reconnected."
- "Write a short post about our spring sale and schedule it on my LinkedIn page for Tuesday at 9:00."
- "Import this image URL and post it with a caption to my Instagram and Facebook accounts."
- "Show my drafts."
- "Which of my posts did best, and what do they have in common?"
- "Summarize my last 30 days of analytics as a short report, then save the report to my content library."
- "Did my post to Mastodon go out? Check its status."

## Tools

15 tools. Full detail is in [docs/tools.md](docs/tools.md).

| Tool | What it does | Scope needed |
|---|---|---|
| `whoami` | Shows the signed-in user, workspace and granted scopes | none |
| `list_connections` | Lists connected social accounts | `connections:read` |
| `check_connection_health` | Finds accounts that need a reconnect | `connections:read` |
| `create_post` | Publishes now or schedules a post to chosen accounts | `posts:write` and `media:upload` |
| `import_media` | Copies an image or video from a public URL into SocialPatra storage | `media:upload` |
| `upload_media` | Uploads a small file sent as base64 (up to 10 MB on the hosted server) | `media:upload` |
| `create_media_upload_link` | Makes a 15 minute page where you drop a file | `media:upload` |
| `get_media_upload` | Returns the URLs of files dropped on that page | `media:upload` |
| `list_drafts` | Lists draft posts | `posts:read` |
| `get_top_performing_posts` | Lists best posts by engagement | `posts:read` |
| `get_post_status` | Shows live per-platform status of a post | `posts:read` |
| `verify_post_platform` | Checks whether a failed post target is actually live | `posts:write` |
| `get_analytics_dashboard` | Returns workspace metrics for a date range | `analytics:read` |
| `search_content_library` | Searches reusable content and templates | `content:read` |
| `save_to_content_library` | Saves a plan, report or snippet for reuse | `content:write` |

## Permissions and safety

- You sign in with your own SocialPatra account. The assistant never sees your password.
- A consent page shows each permission in plain words. You choose the workspace. The connection is bound to that one workspace.
- Permissions are default-deny. A connection can only do what its approved scopes allow, and everything else is refused.
- Connecting or disconnecting social accounts is not possible through MCP. That stays in the SocialPatra web app.
- To disconnect, open **Workspace > Settings > Security > Connected AI apps** in SocialPatra and revoke the app. Access ends right away. Workspace owners and admins can also revoke apps that members connected.

More in [docs/security.md](docs/security.md).

## Plans and limits

- MCP access is part of every paid plan: Professional, Business and Agency. It is not on the Free plan.
- Prices: Professional from $5 or ₹399 a month with one account included, then $3 or ₹149 per extra account. Current prices and plan details are on https://socialpatra.com/pricing.
- If a workspace drops to the Free plan, existing MCP connections stop working at their next token refresh.
- X posting is not included on the Free plan. On paid plans X posts are limited by an included X allowance.
- Each connected account has daily post caps that depend on the plan. They apply to posts made by an assistant the same as posts made in the web app.
- Posts may need approval first, depending on the workspace's approval settings.

## Supported platforms

Posts can be published to 18 platforms: Facebook, Instagram, LinkedIn, X, Threads, Bluesky, Mastodon, Reddit, Tumblr, Medium, Dev.to, Hashnode, WordPress, YouTube, Pinterest, Discord, Slack and Telegram.

TikTok is not supported.

## Privacy and data handling

- A tool call returns data from your workspace to the assistant you connected, for example account names, drafts, post status or analytics. What that assistant provider does with the data is covered by that provider's own terms.
- The assistant holds an access token for the one workspace you approved. Access tokens last 15 minutes and are renewed automatically. A connection that is not used for 7 days needs to be connected again.
- The hosted server records request metadata (method, path, status, timing, IP address) for operations. It does not record your token or the request content.
- SocialPatra's handling of account data is described in the [Privacy Policy](https://socialpatra.com/privacy-policy). Use of the service is covered by the [Terms](https://socialpatra.com/terms).

## Support

Use the support page: https://socialpatra.com/support

## Status and limitations

- Web only. There is no way to connect or disconnect social accounts through MCP.
- The assistant can only use accounts already connected in the web app.
- There is no tool to edit or delete a published post.
- Tools cannot change plan, billing or workspace settings.
- Large files cannot be sent inline. Over 10 MB, use the upload link tool.
- Whether a chat app can send an attached file inline varies by client. The upload link tool works in any client.
- Results depend on the assistant. Check a post before you ask it to publish.

## More

- [Tools reference](docs/tools.md)
- [Security](docs/security.md)
- [FAQ](docs/faq.md)
- Developer page: https://socialpatra.com/developers

Documentation licence: [CC BY 4.0](LICENSE). The server software is proprietary.
