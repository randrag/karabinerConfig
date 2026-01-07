# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Karabiner-Elements configuration for macOS keyboard remapping, using Goku to generate the config from EDN format.

## File Structure

- `karabiner.edn` - Goku source file (edit this)
- `karabiner.json` - Current working config (manually maintained, reference for Goku migration)
- `automatic_backups/` - Karabiner's automatic backups

## Running Goku

Goku by default reads from `~/.config/karabiner.edn` and writes to `~/.config/karabiner/karabiner.json`. To use files in this repo instead:

```bash
# Dry-run (output to stdout, doesn't modify files)
GOKU_EDN_CONFIG_FILE=/Users/roland/code/karabinerConfig/karabiner.edn goku -d

# To actually write to a local karabiner.json, set up directory structure:
mkdir -p /Users/roland/code/karabinerConfig/karabiner
cp karabiner.json karabiner/karabiner.json
XDG_CONFIG_HOME=/Users/roland/code/karabinerConfig GOKU_EDN_CONFIG_FILE=/Users/roland/code/karabinerConfig/karabiner.edn goku
```

**Important:** Goku requires a profile named "Goku" to exist in karabiner.json. Add this to the profiles array:
```json
{
    "complex_modifications": { "rules": [] },
    "name": "Goku",
    "selected": false
}
```

## Goku EDN Syntax Reference

### Modifier Keys
- **Left modifiers:** `C` (command), `T` (control), `O` (option), `S` (shift)
- **Right modifiers:** `Q` (right_command), `W` (right_control), `E` (right_option), `R` (right_shift)
- **Hyper (all right mods):** `!QWER`
- `!` = mandatory, `#` = optional, `##` = optional any

### Common Patterns
```edn
[:!QWERa :b]                           ; hyper+a → b
[:##caps_lock {:key :x :modi [:y]}]    ; caps_lock → x with modifier y
[:from :to [:!AppName]]                ; condition: unless AppName
[:from :to [:AppName]]                 ; condition: if AppName
[:!CSa [:b :c :d]]                     ; cmd+shift+a → b then c then d (sequence)
[:a {:key :b :modi [:shift]}]          ; a → shift+b
[:a {:pointing_button :button2}]       ; a → right click
[:a [:open "/path/to/app"]]            ; a → open application (shell command)
```

### Key Gotchas
- Use `:left_option` not `:left_alt` (Goku doesn't recognize `left_alt`)
- Application regexes need escaped dots: `"^com\\.example\\.app$"`
- Templates like `:open` generate `shell_command`, not `software_function`
- Profile name in EDN (e.g., `:Goku`) must match a profile in karabiner.json

## Current Configuration

The config includes:
- **Hyper key**: Caps Lock → right_shift + right_command + right_control + right_option (except Parallels)
- **Colemak layout**: Full QWERTY→Colemak remapping
- **Hyper + home row**: Arrow keys, navigation (j/k/l/; → arrows, u/o → home/end, 8/, → page up/down)
- **Hyper + Cmd**: Shift-selection variants of navigation keys
- **App-specific rules**: Exceptions for Parallels, Jump Desktop, Rider
- **F# operators**: Cmd-Shift shortcuts for `|>`, `->`, `()`, `||`, `<>`
- **Magic Keyboard fixes**: Right control → option, Home/End → Cmd+arrows
