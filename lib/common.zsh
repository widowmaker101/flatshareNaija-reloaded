#!/usr/bin/env zsh
set -euo pipefail

# Colors
RED=$'%F{1}'; GREEN=$'%F{2}'; YELLOW=$'%F{3}'; BLUE=$'%F{4}'; RESET=$'%f'

log_info()  { print -r -- "${BLUE}ℹ️  $*${RESET}"; }
log_ok()    { print -r -- "${GREEN}✅ $*${RESET}"; }
log_warn()  { print -r -- "${YELLOW}⚠️  $*${RESET}"; }
log_err()   { print -r -- "${RED}❌ $*${RESET}" >&2; }

trap 'log_err "Unexpected error on line $LINENO"; exit 1' ERR

require_cmd() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1 || { log_err "Missing dependency: $cmd"; exit 1; }
}

require_sqlite() { require_cmd sqlite3; }
require_python() { require_cmd python3; }

# Escape single quotes for SQL literals
sql_escape() {
  local s="${1:-}"
  s="${s//\'/\'\'}"
  print -r -- "$s"
}

# Validate Nigerian phone format (basic)
valid_phone() {
  [[ "$1" =~ ^\+?234[0-9]{10}$ ]] || return 1
}

# Validate budget and rent as positive integers
valid_money() {
  [[ "$1" =~ ^[0-9]+$ ]] && [[ "$1" -gt 0 ]]
}

# Assert non-empty
require_arg() {
  local val="${1:-}"; local name="$2"
  [[ -n "$val" ]] || { log_err "Missing: $name"; return 1; }
}
