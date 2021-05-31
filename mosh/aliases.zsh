alias mosh='mosh -6'
mosh-dev() {
  mosh -6 $1 -- tmux a
}
