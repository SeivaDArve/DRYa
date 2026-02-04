#!/bin/bash
L0='drya-emergency-keyboard: `Ctrl-x` Cola uma letra no cursor: '
CHOICE=$(printf "a\nb\nc\n?\n\\ \n^\n@" | fzf --cycle --prompt="$L0")
echo -n "$CHOICE"
