#!/usr/bin/env zsh
moderate_listing() {
  local desc="$1"
  local d="${desc:l}"
  if [[ "$d" == *"2 years upfront"* || "$d" == *"advance fee"* || "$d" == *"pay before viewing"* ]]; then
    print -r -- "Suspicious terms detected"
    return 1
  fi
  return 0
}
