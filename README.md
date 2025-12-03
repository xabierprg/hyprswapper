# HyprSwapper

A lightweight bash script for Hyprland that swaps all windows (clients) between the current workspace and a specified target workspace.

It uses `hyprctl --batch` to ensure the operation happens almost instantaneously, moving windows silently to minimize visual clutter during the swap.

## Dependencies

Make sure you have the following installed on your Arch system:

* **Hyprland**
* **jq** (required for JSON parsing)
* **libnotify** (optional, for error notifications)

To install dependencies on Arch Linux:

```bash
sudo pacman -S jq libnotify
```

## Installation

1.  Clone this repository:
    ```bash
    git clone https://github.com/xabierprg/HyprWSwapper.git
    cd HyprWSwapper
    ```

2.  Make the script executable:
    ```bash
    chmod +x swap_workspaces.sh
    ```

## Usage

Run the script passing the target workspace ID as an argument:

```bash
./swap_workspaces.sh <target_workspace_id>
```

### Hyprland Configuration (`hyprland.conf`)

You can bind this script to a key combination to quickly swap contents.

Add the following to your `hyprland.conf`, adjusting the path to where you saved the script:

```ini
# Example: Swap current workspace with Workspace 1-5 using Super+Alt+[1-5]

bind = $mainMod ALT, 1, exec, /path/to/HyprWSwapper/swap_workspaces.sh 1
bind = $mainMod ALT, 2, exec, /path/to/HyprWSwapper/swap_workspaces.sh 2
bind = $mainMod ALT, 3, exec, /path/to/HyprWSwapper/swap_workspaces.sh 3
bind = $mainMod ALT, 4, exec, /path/to/HyprWSwapper/swap_workspaces.sh 4
bind = $mainMod ALT, 5, exec, /path/to/HyprWSwapper/swap_workspaces.sh 5
```
