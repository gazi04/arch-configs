#!/bin/sh
# Switch a tmux client to the N-th oldest open session (1 = oldest).
# Usage: switch-nth-session.sh N CLIENT
# Session IDs ($0, $1, ...) only grow, so sorting them gives creation order;
# this matches the numbers shown in the status bar (#{S/i:...}).

n="$1"
client="$2"

id=$(tmux list-sessions -F '#{session_id}' | tr -d '$' | sort -n | sed -n "${n}p")
[ -n "$id" ] || exit 0 # no session with that number: do nothing

tmux switch-client -c "$client" -t "\$$id"
