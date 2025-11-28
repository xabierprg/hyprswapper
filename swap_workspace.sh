#!/bin/bash

TARGET_WS=$1

# Check for arguments
if [ -z "$TARGET_WS" ]; then
    echo "Error: No parameter was specified"
    notify-send "Hyprland Script" "No workspace was specified."
    exit 1
fi

# 1. Get current workspace ID
CURRENT_WS=$(hyprctl activeworkspace -j | jq '.id')

# Exit if target is same as current
if [ "$CURRENT_WS" == "$TARGET_WS" ]; then
    hyprctl dispatch workspace $TARGET_WS
    exit 0
fi

# 2. Get all clients JSON
CLIENTS_JSON=$(hyprctl clients -j)

# 3. Init dispatch command string
DISPATCH_CMDS=""

# 4. Queue move: Current WS clients -> Target WS
CURRENT_CLIENTS=$(echo "$CLIENTS_JSON" | jq -r --argjson ws "$CURRENT_WS" '.[] | select(.workspace.id == $ws) | .address')

for addr in $CURRENT_CLIENTS; do
    DISPATCH_CMDS+="dispatch movetoworkspacesilent $TARGET_WS,address:$addr;"
done

# 5. Queue move: Target WS clients -> Current WS
TARGET_CLIENTS=$(echo "$CLIENTS_JSON" | jq -r --argjson ws "$TARGET_WS" '.[] | select(.workspace.id == $ws) | .address')

for addr in $TARGET_CLIENTS; do
    DISPATCH_CMDS+="dispatch movetoworkspacesilent $CURRENT_WS,address:$addr;"
done

# 6. Queue focus switch to target WS
DISPATCH_CMDS+="dispatch workspace $TARGET_WS;"

# 7. Execute batch
if [ -n "$DISPATCH_CMDS" ]; then
    hyprctl --batch "$DISPATCH_CMDS"
fi