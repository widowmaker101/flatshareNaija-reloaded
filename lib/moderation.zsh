#!/usr/bin/env zsh
moderate_listing() {
  local desc="${1:l}"  # lowercase
  local badterms=(
    "2 years upfront" "advance fee" "pay before viewing" "no receipt"
    "non-refundable viewing fee" "agent must collect cash" "send money first"
  )
  for t in "${badterms[@]}"; do
    [[ "$desc" == *"$t"* ]] && { print -r -- "Suspicious: $t"; return 1; }
  done
  return 0
}
