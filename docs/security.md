# Security

## How sign-in works

1. You add the server URL to your assistant.
2. The assistant registers itself with SocialPatra automatically (OAuth 2.1 dynamic client registration) and sends you to SocialPatra in your browser. It uses PKCE with S256.
3. You sign in to SocialPatra with your own account. If you belong to more than one workspace, you choose the workspace to connect.
4. The consent page lists each permission in plain words. You choose Allow or Deny.
5. The assistant receives an access token for that one workspace and that set of permissions.

Your SocialPatra password is never shared with the assistant.

## Scopes

| Scope | What the consent page says | Used by |
|---|---|---|
| `connections:read` | View your connected social accounts | `list_connections`, `check_connection_health` |
| `analytics:read` | View your analytics | `get_analytics_dashboard` |
| `posts:read` | View your posts and drafts | `list_drafts`, `get_top_performing_posts`, `get_post_status` |
| `posts:write` | Create and schedule posts | `create_post`, `verify_post_platform` |
| `media:upload` | Attach media to posts | `create_post` (together with `posts:write`), `import_media`, `upload_media`, `create_media_upload_link`, `get_media_upload` |
| `content:read` | View your content library | `search_content_library` |
| `content:write` | Save items to your content library | `save_to_content_library` |

If an assistant asks for no specific scopes, it gets a read-only default: `posts:read`, `connections:read`, `analytics:read` and `content:read`. Posting needs `posts:write` and `media:upload`, which must be requested and approved.

## Default-deny

A connection with scopes can only reach actions that are tied to a scope it holds, plus the identity check. Any other SocialPatra action is refused, even for a signed-in user. Scopes are enforced by the SocialPatra API, not by the assistant or the MCP server.

## One workspace per connection

The workspace is chosen on the consent page and checked against your current membership. A connection cannot read or write other workspaces. If you lose access to the workspace, the connection stops working at its next token refresh.

## Token lifetime and revocation

- Access tokens last 15 minutes. The assistant renews them with a refresh token.
- A refresh token is valid for 7 days from when it was issued, and each renewal issues a new one.
- Revoke an app any time in **Workspace > Settings > Security > Connected AI apps**. Access ends right away and the app has to be connected again to be used.
- Workspace owners and admins can revoke apps that any member connected to the workspace. The member gets an email.
- An app whose access already ended (for example after a password change, a plan change or leaving the workspace) can stay listed there for up to 7 days.
- MCP access needs a paid plan. The plan is checked again at each token renewal.

## What the server can and cannot do

- Connecting or disconnecting social accounts is not available through MCP.
- Upload links give upload access to the workspace for 15 minutes and for up to 10 files. Treat the link like a password and do not share it.
- Origins allowed to call the server from a browser are limited to Claude and ChatGPT web apps. Clients that are not browsers are not affected.

## Report a vulnerability

Use the support page at https://socialpatra.com/support and say it is a security report. Do not include secrets or other users' data in the report.
