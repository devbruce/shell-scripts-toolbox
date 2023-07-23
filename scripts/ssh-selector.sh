#!/usr/bin/env bash
set -e

SSH_DIR="$HOME/.ssh"
SSH_CONFIG_PATH="$SSH_DIR/config"
SELECTED_HOST=$(cat $SSH_CONFIG_PATH | awk '$1 == "Host" { print $2 }' | fzf)
ssh $SELECTED_HOST
