# Tools reference

The server exposes 15 tools. Each tool needs the scope shown. You grant scopes on the consent page when you connect. All tools act on the one workspace you approved.

Results come back to the assistant as JSON text. Common errors, in plain words:

- **Authorization expired or revoked:** reconnect SocialPatra in your assistant.
- **Permission missing:** reconnect SocialPatra and approve the needed scope on the consent screen.
- **Plan error:** MCP needs a paid plan.

Hint labels used below: read-only means the tool changes nothing; writes means it changes data in your workspace or publishes; contacts platforms means it may call the social platforms.

## whoami

Purpose: confirm the connection and show who is signed in. Call it first if anything fails.
Inputs: none.
Output: user, workspace, auth type and the list of granted scopes.
Scope: none (any valid connection). Read-only.
Example: "Use SocialPatra: who am I?"
Errors: reconnect if authorization expired.

## list_connections

Purpose: list the social accounts connected in the workspace. The assistant needs the account ids from this before it can post.
Inputs: `includeAllStatuses` (boolean, optional). Also lists disconnected accounts. Default is active and reconnect-required only.
Output: for each account, an id (called `platformId`), the provider, the profile name and the status.
Scope: `connections:read`. Read-only.
Example: "List my connected accounts."
Errors: reconnect or missing scope.

## check_connection_health

Purpose: check the tokens of all connected accounts and report which need to be reconnected.
Inputs: `force` (boolean, optional). Skips the 10 minute cache and checks live.
Output: per-account health result.
Scope: `connections:read`. Contacts platforms.
Example: "Check whether any of my accounts need reconnecting."
Errors: reconnect or missing scope. Reconnecting an account itself is done in the web app.

## create_post

Purpose: create a post and publish it now or schedule it.
Inputs:
- `platforms` (list, required, at least one). Each item has `platformId` (required, from `list_connections`), and optional `platform`, `provider` and `content` (a per-account text override).
- `postType` (required). One of text, image, video, link, carousel, thread, poll, reel, story.
- `content` (text, optional). Shared text for all accounts without an override.
- `title` (text, optional). For blog-style platforms.
- `url` (link, optional). A link to attach.
- `mediaUrls` (list of links, optional). Image or video URLs. Use a SocialPatra-hosted URL from `import_media`, `upload_media` or `get_media_upload`.
- `carouselItems` (list, optional). 2 to 20 slides for a carousel. Each has `mediaUrl` (required), `caption` and `link`.
- `threadParts` (list, optional). 2 or more parts for a thread. Each has `content` (required) and `mediaUrls`.
- `pollData` (object, optional). `question`, `options` (2 to 4), `durationMinutes` (at least 5), `multipleChoice` (optional).
- `schedule` (date and time, optional). ISO 8601, for example `2026-06-15T14:30:00Z`. Leave it out to publish now.
- `tags` (list of text, optional). Internal tags.

Output: the created post, including its post id for `get_post_status`.
Scope: `posts:write` and `media:upload`, both required. Writes and publishes, contacts platforms.
Example: "Schedule this text post on my LinkedIn page for tomorrow at 9:00."
Errors: missing scope; invalid input such as a poll with one option; an approval rule in the workspace may hold the post for review instead of publishing it; a plan limit or daily cap may refuse the post.

## import_media

Purpose: copy an image or video from a public URL into SocialPatra storage so it can be used in a post.
Inputs: `url` (link, required, must be publicly reachable) and `mediaType` (required: image, video, gif, audio or document).
Output: the SocialPatra-hosted URL.
Scope: `media:upload`. Writes, contacts the source URL.
Example: "Import https://example.com/photo.jpg as an image."
Errors: the URL cannot be fetched; missing scope.

## upload_media

Purpose: upload a file the assistant has as base64 content and get a hosted URL.
Inputs: `mediaType` (required). `base64Content` (required on the hosted server; `dataBase64` is the older name for the same field). `filename` (for example `photo.png`) or `mimeType`, one of which is needed.
Output: the hosted URL.
Scope: `media:upload`. Writes.
Limits: 10 MB on the hosted server. Allowed types are jpg, png, gif, webp, mp4, mov, webm, mp3 and wav. The real file content decides the type, and placeholder or text content is refused. The `filePath` input only works for a locally run server and is refused on the hosted one.
Example: "Upload the attached image and post it."
Errors: too large (use `create_media_upload_link`), wrong or unrecognized type, missing scope.

## create_media_upload_link

Purpose: for a file on your device or in the chat that the assistant cannot read. It returns a page link you open to drop the file.
Inputs: `mediaType` (optional).
Output: a page link, an expiry time and a link id.
Scope: `media:upload`. Writes.
Limits: the link gives upload access to the workspace for 15 minutes and for up to 10 files. Do not share it.
Example: "I want to post a video from my laptop."
Errors: missing scope.

## get_media_upload

Purpose: get the URLs of the files you dropped on the upload page.
Inputs: `linkId` (text, required, from `create_media_upload_link`).
Output: whether the link expired, and the list of uploaded files with their URLs.
Scope: `media:upload`. Read-only.
Example: "I uploaded the file, continue."
Errors: the link expired (make a new one); missing scope.

## list_drafts

Purpose: list your draft posts.
Inputs: `page` (number, optional), `pageSize` (number, optional, default 20, max 100), `sortOrder` (asc or desc, optional, by creation date, default desc).
Output: the drafts and paging details.
Scope: `posts:read`. Read-only.
Example: "Show my newest drafts."
Errors: missing scope.

## get_top_performing_posts

Purpose: list your best published posts, ranked by likes, comments, shares and clicks together.
Inputs: `page` (number, optional), `limit` (number, optional, default 12, max 50).
Output: ranked posts and paging details.
Scope: `posts:read`. Read-only.
Example: "What were my top posts?"
Errors: missing scope.

## get_post_status

Purpose: show the live publishing status of one post, per platform.
Inputs: `postId` (text, required).
Output: the status for each target account.
Scope: `posts:read`. Read-only.
Example: "Check the status of the post you just scheduled."
Errors: post not found; missing scope.

## verify_post_platform

Purpose: when a target shows as failed, check on the platform whether it actually went live (a publish can time out after the platform accepted it). Use it before retrying to avoid a duplicate.
Inputs: `postId` (required), `platformPostId` (required, from `get_post_status`), `confirmNotPublished` (boolean, optional; set it only after you have confirmed on the platform that the post is not live).
Output: an outcome of found, absent, inconclusive, unsupported or user_confirmed.
Scope: `posts:write`. Contacts platforms.
Example: "The Mastodon target failed. Check if it is really not posted."
Errors: only failed targets can be verified, so another status returns a conflict error; missing scope.

## get_analytics_dashboard

Purpose: workspace metrics for a date range: total posts, likes, comments, shares, reach, engagement, follower growth, per-platform split and a daily trend.
Inputs: `startDate` (YYYY-MM-DD, optional, default 30 days ago), `endDate` (YYYY-MM-DD, optional, default today).
Output: the aggregated figures.
Scope: `analytics:read`. Read-only. Analytics is a paid-plan feature.
Example: "Summarize my last 30 days."
Errors: bad date format; missing scope.

## search_content_library

Purpose: search your reusable content: posts, templates, snippets, calls to action and hashtag sets.
Inputs: `search` (text), `tags` (list), `type` (one of text, image, video, template, draft, snippet, hashtag_set, cta), `page`, `limit` (max 100). All optional.
Output: matching items and paging details.
Scope: `content:read`. Read-only.
Example: "Find my saved hashtag sets for product launches."
Errors: missing scope.

## save_to_content_library

Purpose: save a plan, report, drafted post or snippet into the content library.
Inputs: `title` (required, max 500 characters), `content` (required), `type` (optional, same list as above, default text), `tags` (optional), `notes` (optional).
Output: the saved item.
Scope: `content:write`. Writes.
Example: "Save this content plan to my library as a template."
Errors: missing scope; title too long.
