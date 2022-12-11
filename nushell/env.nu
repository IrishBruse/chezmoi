def create_right_prompt [] {
  let milis = ($env.CMD_DURATION_MS | into int)
  if ($milis) < 1000 {
    ($milis | into string) + " ms"
  } else  {
    (($milis / 1000) | into string) + " s"
  }
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { $"(ansi light_gray)($env.PWD)" }
let-env PROMPT_COMMAND_RIGHT = { $"(ansi green)(create_right_prompt)" }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { $"(ansi light_gray) → " }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "→ " }
let-env PROMPT_MULTILINE_INDICATOR = { "→ " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | path expand | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | path expand | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]