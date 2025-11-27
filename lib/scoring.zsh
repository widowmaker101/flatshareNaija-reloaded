#!/usr/bin/env zsh
score_listing() {
  local rent="$1" budget="$2" lifestyle="$3" generator="$4" inverter="$5"
  local score=0
  [[ "$rent" -le "$budget" ]] && ((score+=50))
  [[ "$generator" -eq 1 ]] && ((score+=20))
  [[ "$inverter" -eq 1 ]] && ((score+=20))
  [[ "$lifestyle" == "remote" ]] && ((score+=10))
  echo "$score"
}
