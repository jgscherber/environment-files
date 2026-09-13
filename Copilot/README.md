# Copilot Setup Guide


## MCP Setup

### Obsidian

Replace `YOUR_OBSIDIAN_API_KEY` with your actual Obsidian API key. The config is stored in my Windows user profile directory, so the key isn't committed in the repo.

The tools listed are read-only tools.

```
copilot mcp add --transport http `
  --header "Authorization: YOUR_OBSIDIAN_API_KEY" `
  --tools "vault_list,vault_read,vault_read_binary,vault_get_document_map,active_file_get_path,search_query,search_simple,tag_list,command_list" `
  obsidian http://127.0.0.1:27123/mcp
```