#!/bin/bash

LOG_FILE="cmdlog.txt"

get_command_history() {
    if [[ "$SHELL" == *"bash"* ]]; then
        history_file="$HOME/.bash_history"
    elif [[ "$SHELL" == *"zsh"* ]]; then
        history_file="$HOME/.zsh_history"
    else
        echo "Unsupported shell. Exiting." >&2
        exit 1
    fi

    if [[ -f "$history_file" ]]; then
        cat "$history_file"
    else
        echo "No command history file found. Exiting." >&2
        exit 1
    fi
}

write_log() {
    local history_lines="$1"
    {
        echo "--- Update: $(date '+%Y-%m-%d %H:%M:%S') ---"
        echo "$history_lines"
    } > "$LOG_FILE"
}

main() {
    history=$(get_command_history)
    if [[ -n "$history" ]]; then
        write_log "$history"
    else
        echo "No command history found."
    fi
}

main