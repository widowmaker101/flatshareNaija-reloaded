#!/usr/bin/env zsh
set -euo pipefail

# Colors
RED=$'%F{1}'; GREEN=$'%F{2}'; YELLOW=$'%F{3}'; BLUE=$'%F{4}'; MAGENTA=$'%F{5}'; RESET=$'%f'

# Logging
log_info()  { print -r -- "${BLUE}ℹ️  $*${RESET}"; }
log_ok()    { print -r -- "${GREEN}✅ $*${RESET}"; }
log_warn()  { print -r -- "${YELLOW}⚠️  $*${RESET}"; }
log_err()   { print -r -- "${RED}❌ $*${RESET}" >&2; }

trap 'log_err "Unexpected error on line $LINENO"; exit 1' ERR

# Dependencies
require_cmd() { command -v "$1" >/dev/null 2>&1 || { log_err "Missing dependency: $1"; exit 1; }; }
require_sqlite() { require_cmd sqlite3; }
require_python() { require_cmd python3; }
require_jq()     { require_cmd jq; }

# Config
APP_ROOT="${0:a:h:h}"
FSN_DB="${FSN_DB:-$APP_ROOT/db/flatshare.db}"
FSN_BACKUP_DIR="${FSN_BACKUP_DIR:-$APP_ROOT/backups}"
mkdir -p "$FSN_BACKUP_DIR"

# SQL helpers
sql_escape() { local s="${1:-}"; s="${s//\'/\'\'}"; print -r -- "$s"; }

# Validation
valid_phone() { [[ "$1" =~ ^\+?234[0-9]{10}$ ]]; }
valid_money() { [[ "$1" =~ ^[0-9]+$ ]] && [[ "$1" -gt 0 ]]; }
require_arg() { [[ -n "${1:-}" ]] || { log_err "Missing: $2"; return 1; } }

# Pagination: prints stdin paginated (page size default 10)
paginate() {
  local per="${1:-10}" i=0
  local buffer=()
  while IFS= read -r line; do
    buffer+=("$line"); ((i++))
    if (( i % per == 0 )); then
      printf "%s\n" "${buffer[@]}"
      buffer=()
      read -sk1 "?${MAGENTA}-- more (press any key to continue) --${RESET}"
      print -r -- ""
    fi
  done
  (( ${#buffer[@]} )) && printf "%s\n" "${buffer[@]}"
}
