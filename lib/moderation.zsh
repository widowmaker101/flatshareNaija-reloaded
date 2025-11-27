#!/usr/bin/env zsh
moderate_listing() {
  local desc="$1"
  if [[ "$desc" == *"2 years upfront"* || "$desc" == *"advance fee"* || "$desc" == *"pay before viewing"* ]]; then
    echo "⚠️ Suspicious terms detected"
    return 1
  fi
  return 0
}
