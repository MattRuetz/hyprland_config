#!/bin/bash
# Per-session tmux color theming
# Usage: session-color.sh auto   — pick color based on session index
#        session-color.sh next   — cycle to next color
#        session-color.sh <name> — set a specific color by name

COLORS=(blue colour205 green yellow red cyan magenta colour208)
NAMES=(blue pink green yellow red cyan magenta orange)

session=$(tmux display-message -p '#S')

apply_color() {
    local c=$1
    tmux set status-left "#[fg=black,bg=${c},bold] #S #[bg=default] "
    tmux set status-right "#[fg=${c}]#{?client_prefix,PREFIX ,}#{?window_zoomed_flag,ZOOM ,}#[fg=brightblack]#h "
    tmux set pane-active-border-style "fg=${c},bold"
    tmux set message-style "bg=${c},fg=black,bold"
    tmux set message-command-style "bg=brightblack,fg=${c}"
    tmux set mode-style "bg=${c},fg=black,bold"
    tmux setw clock-mode-colour "${c}"
    tmux set popup-border-style "fg=${c}"
    tmux set @session-color-index "$2"
}

case "$1" in
    auto)
        # Count existing sessions to pick a unique color
        count=$(tmux list-sessions 2>/dev/null | wc -l)
        idx=$(( (count - 1) % ${#COLORS[@]} ))
        apply_color "${COLORS[$idx]}" "$idx"
        ;;
    next)
        current=$(tmux show -qv @session-color-index 2>/dev/null)
        current=${current:-0}
        idx=$(( (current + 1) % ${#COLORS[@]} ))
        apply_color "${COLORS[$idx]}" "$idx"
        tmux display-message "Session color: ${NAMES[$idx]}"
        ;;
    *)
        # Match by name
        for i in "${!NAMES[@]}"; do
            if [[ "${NAMES[$i]}" == "$1" ]]; then
                apply_color "${COLORS[$i]}" "$i"
                tmux display-message "Session color: ${NAMES[$i]}"
                exit 0
            fi
        done
        echo "Unknown color: $1. Available: ${NAMES[*]}"
        ;;
esac
