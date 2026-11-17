# FAQ

## Does the assistant post without asking me?

It posts when you ask it to, and only if the connection has the posting permission. You can approve read permissions only on the consent page, and then it cannot post at all. Ask the assistant to show you the text and the accounts before it publishes. If your workspace uses approvals, posts may wait for review first.

## Which SocialPatra plans include MCP?

Professional, Business and Agency include MCP access. The Free plan does not. If a workspace drops to Free, its MCP connections stop working at the next token renewal, and the assistant has to be connected again after you upgrade. Current prices and plan details are listed on https://socialpatra.com/pricing.

## Which assistants work?

Any client that supports remote MCP servers with OAuth sign-in. The README has setup steps for the Claude apps, Claude Code, ChatGPT, Cursor, Gemini CLI and the OpenAI Codex CLI. Each vendor decides which of its own plans can add custom servers, so check the plan you use with that assistant.

## Can an agency use it for each client?

Yes. Each connection is bound to one workspace, and an agency keeps one workspace per client. Connect the assistant once for each client workspace and pick that workspace on the consent page. A connection can never reach the other workspaces, so one client's accounts and data stay separate from another's.

## What data does the assistant see?

Only what the tools return from the one workspace you approved, within the permissions you granted. That can be account names, drafts, post status, analytics or content library items. It does not see your password, your billing details or any other workspace. What the assistant provider does with returned data follows that provider's own terms.

## Can it connect or disconnect my social accounts?

No. Connecting and disconnecting social accounts needs a sign-in popup on each platform, so it stays in the SocialPatra web app. The assistant can only use accounts that are already connected. It can tell you which accounts need a reconnect, and you then fix that in the web app yourself.

## Can it edit or delete a post that is already published?

No. There is no tool for that. The assistant can create and schedule posts, read their status, and check whether a failed target actually went live. To change or remove a published post, use the SocialPatra web app or the social platform itself. Scheduled and draft posts are also managed in the web app.

## Does MCP cost extra?

There is no separate MCP charge. MCP access is included in the Professional, Business and Agency plans. SocialPatra plans are priced per connected account, with one account included in Professional and Business. Your AI assistant has its own plan and bill from its vendor, which SocialPatra does not control or charge.

## How do I disconnect an assistant?

Open Workspace, then Settings, then Security, then Connected AI apps in SocialPatra, and revoke the app. Its access ends right away. You can also remove the connector inside the assistant, but revoking it in SocialPatra is what actually ends the access. Workspace owners and admins can revoke apps that members connected.

## Which platforms can it post to?

It can post to Facebook, Instagram, LinkedIn, X, Threads, Bluesky, Mastodon, Reddit, Tumblr, Medium, Dev.to, Hashnode, WordPress, YouTube, Pinterest, Discord, Slack and Telegram. TikTok is not supported. Only accounts you already connected in the web app can be used, and each platform has its own post type rules.

## Can I send a photo or video from my computer?

Yes, in three ways. For a public URL, the assistant imports it. For a small file, an assistant that can attach files may send it inline, up to 10 MB. For anything else, the assistant gives you a link that is valid for 15 minutes. Open it, drop the file, and the assistant continues.

## Where do I get help?

Use the support page at https://socialpatra.com/support. Describe what you asked the assistant, which assistant you used, and the error text it showed. Do not include passwords, tokens or upload links in a support message. For a security report, say so in the first line of the message.
