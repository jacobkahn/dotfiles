alias mosh='mosh -6'
dev() {
  mosh -6 $1 -- tmux a
}
