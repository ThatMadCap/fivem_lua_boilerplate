# FiveM Lua Resource Boilerplate

A resource boilerplate for simple use. Includes structured project layout, pre-configured tooling, and bridge system. Built to eliminate repetitive setup work.

## Features

- **ox_lib Integration**: Built to use with [ox_lib](https://github.com/communityox/ox_lib)
- **Bridge System**: Detects external resources and loads appropriate implementations, providing global functions for cross-resource compatibility
- **Auto-formatting**: StyLua and Prettier configured with format-on-save in VSCode
- **GitHub Actions**: Automated release workflow with version bumping and code formatting
- **Modular Structure**: Organised directories for client, server, bridge, modules, config, data, and locales
- **VSCode Integration**: Pre-configured workspace settings and recommended extensions
- **Example Code**: Reference implementations for events, callbacks, commands, and utilities

## Quick Start

1. Clone or download this template
2. Ensure `ox_lib` is installed
3. Find and replace globally:
   - `RESOURCE_NAME` → Your resource name
   - `GITHUB_USERNAME` → Your GitHub username
4. Remove directories and example code you don't need for your project
5. Update `fxmanifest.lua` metadata (author, description, version)
6. Start building your resource

## Project Structure

```
bridge/          Resource compatibility layer
  notify/        Config-selectable notification bridge (ox_lib, custom)
  dispatch/      Auto-detect dispatch bridge (example)
client/          Client-side entry point (cl_main.lua)
server/          Server-side entry point (sv_main.lua)
shared/          Shared code (sh_main.lua)
modules/         Modular functionality
  shared/        Shared utilities (utils.lua)
  client/        Client modules (module.lua example)
  server/        Server modules (commands.lua example)
config/          Configuration files (client.lua, server.lua, shared.lua)
data/            Static data (data.json example)
locales/         Translation files (en.json)
web/             UI pages and assets (HTML, CSS, JavaScript)
.vscode/         Editor settings and recommended extensions
.github/         CI/CD workflows and actions
```

**Note:** When adding or removing directories, update the corresponding directives in `fxmanifest.lua` (`client_scripts`, `server_scripts`, `shared_scripts`, `files`).

## Core Systems

### Bridge System

Bridges detect external resources at runtime and load appropriate implementations, exposing global functions for use throughout your code. Two patterns are included:

**Pattern 1: Config-Selectable (`bridge/notify/`)**

- User chooses which resource via config (e.g., `config.shared.notify.type`)
- Falls back to custom if configured or nothing found
- Example: `ClientNotify.Notify(data)` / `ServerNotify.Notify(target, data)`

**Pattern 2: Auto-Detect (`bridge/dispatch/`)**

- Automatically uses first detected resource from a list
- No config needed, purely runtime detection
- Example: `ClientDispatch.Dispatch(data)` / `ServerDispatch.Dispatch(target, data)`

#### How Bridges Work

1. Bridge loader checks `GetResourceState()` for external resources
2. Loads matching implementation file via `lib.load()`
3. Implementation defines global functions (e.g., `ClientNotify.Notify`)
4. Your code calls these global functions anywhere in the resource

#### Adding a Resource to an Existing Bridge

1. Create implementation directory: `bridge/<bridge_type>/<resource_name>/`
2. Add client.lua and/or server.lua with global function definitions
3. Add resource to the detection table in `bridge/<bridge_type>/client.lua`:

```lua
local notify = {
    { name = 'ox_lib', bridge = 'ox' },
    { name = 'mad-thoughts', bridge = 'mad' }, -- new entry
}
```

4. Repeat for server.lua if needed

#### Creating a New Bridge Type

1. Copy an example:
   - `bridge/notify/` - for config-selectable pattern
   - `bridge/dispatch/` - for auto-detect pattern
2. Rename to your bridge type: `bridge/<your_bridge>/`
3. Replace all instances of the bridge name throughout client.lua and/or server.lua:
   - `notify` → `<your_bridge>` (e.g., `dispatch`, `target`, `menu`)
4. Delete client.lua or server.lua if only needed on one side
5. Add bridge loader to fxmanifest.lua:
   - `client_scripts`: `'bridge/<your_bridge>/client.lua'`
   - `server_scripts`: `'bridge/<your_bridge>/server.lua'`
6. Define your global functions in each implementation file
7. Use the global functions in your code: `Client<YourBridge>.YourFunction()`

### Locales

Uses ox_lib's locale system with JSON files in `locales/`. Supports variable interpolation with `${variableName}` syntax.

Add new languages by creating `locales/<lang>.json`. Ensure `lib.locale()` is loaded into a particular scope (or shared).

### Auto-formatting

Formatting rules are defined in `.editorconfig`, `stylua.toml`, and `.prettierrc`. Format-on-save is enabled by default in VSCode. GitHub release workflow also formats code automatically.

### GitHub Release Workflow

When you push a git tag in the format `v*.*.*` (e.g., `v1.0.0`):

1. Formats all code with StyLua and Prettier
2. Bumps the version in `fxmanifest.lua`
3. Creates a ZIP file of the resource
4. Publishes a GitHub release with the ZIP attached

If you have removed or added directories or root files, you will want to edit `release.yml` bundle files.

## Development Setup

When you open the workspace in VSCode, you'll be prompted to install recommended extensions:

- **StyLua**: Lua formatter
- **Prettier**: JSON/MD formatter
- **EditorConfig**: Multi-editor config support
- **CfxLua**: FiveM/RedM IntelliSense
- **Lua**: Lua language server

Format-on-save is pre-configured in `.vscode/settings.json`.

## Example Code

Example files in `client/`, `server/`, `shared/`, and `modules/` demonstrate common patterns and provide a structured script layout with comments. Shows usage of bridges, callbacks, modules, and other boilerplate features. Use as reference or delete when building your resource.

## Configuration

- **fxmanifest.lua**: Update metadata fields (author, description, version)
- **config/client.lua**: Client-side configuration (accessed via `lib.require('config.client')`)
- **config/server.lua**: Server-side configuration (e.g., `enableCommands`)
- **config/shared.lua**: Shared configuration (e.g., `notify.type` for bridge selection)
- **locales/\*.json**: Add translations for your resource
- **.github/FUNDING.yml**: Update with your funding links or remove the file

**Note:** Config files are loaded via `lib.require()` and accessible from files listed in the `files` directive.

## Dependencies

- [ox_lib](https://github.com/communityox/ox_lib)

## License

Choose your own license. The template itself has no restrictions.
