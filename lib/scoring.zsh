#!/usr/bin/env zsh
score_listing() {
  local rent="$1" budget="$2" lifestyle="$3" has_gen="$4" has_inv="$5"
  local score=0
  (( rent <= budget )) && ((score+=50))
  (( has_gen == 1 )) && ((score+=20))
  (( has_inv == 1 )) && ((score+=20))
  [[ "$lifestyle" == "remote" ]] && ((score+=10))
  print -r -- "$score"
}
