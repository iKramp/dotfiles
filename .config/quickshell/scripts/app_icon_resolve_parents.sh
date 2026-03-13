#!/usr/bin/env bash

# Usage: resolve-desktop-from-parent.sh <pid>

get_entry() {
    local file="$1"
    #  find icon=
    icon_line=$(grep -E '^Icon=' "$file" 2>/dev/null | head -n1)
    echo "${icon_line#Icon=}"
}

PID="$1"

if [[ -z "$PID" || ! -d "/proc/$PID" ]]; then
    exit 0
fi

# Collect desktop files
DESKTOP_DIRS=(
    "$HOME/.local/share/applications"
    "/usr/share/applications"
    "/var/lib/flatpak/exports/share/applications"
    "/run/current-system/sw/share/applications"
)

# Build desktop cache (name -> file)
declare -A DESKTOP_MAP

for dir in "${DESKTOP_DIRS[@]}"; do
    [[ -d "$dir" ]] || continue
    while IFS= read -r file; do
        base=$(basename "$file" .desktop)
        DESKTOP_MAP["$base"]="$file"
    done < <(find "$dir" -maxdepth 1 -name "*.desktop" 2>/dev/null)
done

# Walk parent chain
CURRENT="$PID"

while [[ "$CURRENT" -gt 1 && -d "/proc/$CURRENT" ]]; do
    COMM=$(tr -d '\0' < /proc/$CURRENT/comm 2>/dev/null)
    EXE=$(basename "$(readlink -f /proc/$CURRENT/exe 2>/dev/null)")

    # Try exact match
    if [[ -n "${DESKTOP_MAP[$COMM]}" ]]; then
        get_entry "${DESKTOP_MAP[$COMM]}"
        exit 0
    fi

    if [[ -n "${DESKTOP_MAP[$EXE]}" ]]; then
        get_entry "${DESKTOP_MAP[$EXE]}"
        exit 0
    fi

    # Try partial match (steam_app_*, etc.)
    for key in "${!DESKTOP_MAP[@]}"; do
        if [[ "$COMM" == *"$key"* ]] || [[ "$key" == *"$COMM"* ]]; then
            get_entry "${DESKTOP_MAP[$key]}"
            exit 0
        fi
    done

    # Move to parent
    CURRENT=$(awk '{print $4}' /proc/$CURRENT/stat 2>/dev/null)

    [[ -z "$CURRENT" ]] && break
done

exit 0
