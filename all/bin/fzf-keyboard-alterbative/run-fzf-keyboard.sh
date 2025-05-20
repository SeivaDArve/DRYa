#!/bin/bash
CHOICE=$(printf "a\nb\nc\n" | fzf --prompt="Escolhe uma letra: ")
echo -n "$CHOICE"
