{
  wayland.windowManager.hyprland.extraConfig = ''
    ###################
    ### KEYBINDINGS ###
    ###################

    # See https://wiki.hyprland.org/Configuring/Keywords/
    $mainMod = SUPER
    $secMod = CONTROL
    $meh = MOD5
    $hyper = SUPER MOD5
    $terminal = kitty sh -c "~/.config/hypr/scripts/assets/tty.sh; exec fish"
    $fileManager = nautilus
    $browser = firefox
    $drun = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/drun.sh"
    $run = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/run.sh"
    $emoji = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/emoji.sh; kitty @ close-window"
    $clipboard = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/clipboard.sh; kitty @ close-window"
    $loadbuku = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/hypr/scripts/load-buku.sh"
    $pass = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/pass.sh password"
    $otp = kitty -T fzf -o cursor_trail=0 fish -c "~/.config/fzf/extra/pass.sh otp"

    bind = $mainMod, Q, exec, ~/.config/hypr/scripts/quit.sh
    bind = $hyper, code:49, exit # "`"
    bind = $mainMod, RETURN, exec, $terminal
    bind = $mainMod, code:61, exec, $browser # "/"
    bindr = $mainMod, code:48, exec, pkill $fileManager || $fileManager # "'"
    bind = $mainMod, M, exec, ~/.config/hypr/scripts/assets/mpv.sh
    bindr = $mainMod, SPACE, exec, pkill fzf || $drun
    bindr = $secMod, SPACE, exec, pkill fzf || $run
    bindr = $mainMod, code:60, exec, pkill fzf || $emoji # "."
    bindr = $mainMod, V, exec, pkill fzf || $clipboard
    bind = $mainMod, code:59, exec, ~/.config/qmk/cheatsheet-wrapper.sh # ","
    bind = $mainMod, T, exec, ~/.config/hypr/scripts/word-lookup.sh
    bind = $mainMod, R, exec, ~/.config/hypr/scripts/deepl-terjemah.sh
    bind = $mainMod, E, exec, ~/.config/hypr/scripts/deepl-translate.sh
    bind = $mainMod, L, exec, ~/.config/hypr/scripts/hyprlock.sh
    bind = $mainMod, B, exec, $loadbuku

    bind = $meh, Q, exec, ~/.config/waybar/scripts/screenshot/ssmonitor.sh
    bind = $hyper, Q, exec, ~/.config/waybar/scripts/screenrecord/recmonitor.sh
    bind = $meh, W, exec, ~/.config/waybar/scripts/screenshot/sswindow.sh
    bind = $hyper, W, exec, ~/.config/waybar/scripts/screenrecord/recwindow.sh
    bind = $meh, E, exec, ~/.config/waybar/scripts/screenshot/ssarea.sh
    bind = $hyper, E, exec, ~/.config/waybar/scripts/screenrecord/recarea.sh
    bind = $meh, R, exec, ~/.config/waybar/scripts/screenshot/ocr.sh
    bind = $meh, V, exec, ~/.config/waybar/scripts/pavucontrol/cycle-output.sh
    bind = $meh, C, exec, ~/.config/waybar/scripts/pavucontrol/toggle-output.sh
    bind = $hyper, V, exec, ~/.config/waybar/scripts/pavucontrol/cycle-input.sh
    bind = $hyper, C, exec, ~/.config/waybar/scripts/pavucontrol/toggle-input.sh
    bind = $meh, Y, exec, ~/.config/waybar/scripts/utility/virtualkeyboard.sh
    bind = $hyper, Y, exec, pgrep sysboard | xargs kill && notify-send 'Virtual Keyboard' 'Off' -i keyboard
    bind = $meh, U, exec, hyprpicker -a
    bind = $hyper, U, exec, ~/.config/waybar/scripts/hyprsunset/scroll-down.sh
    bind = $meh, I, exec, ~/.config/waybar/scripts/dunst/dunsticon.sh
    bind = $hyper, I, exec, ~/.config/waybar/scripts/hyprsunset/scroll-up.sh
    bind = $meh, O, exec, hyprctl dispatch setprop active opaque toggle
    bind = $hyper, O, exec, ~/.config/waybar/scripts/hyprsunset/hyprsunset.sh
    bind = $hyper, B, exec, ~/.config/hypr/scripts/save-buku.sh
    bind = $meh, P, exec, pkill fzf || hyprctl activewindow -j > /tmp/prev_window && $pass
    bind = $hyper, P, exec, pkill fzf || hyprctl activewindow -j > /tmp/prev_window && $otp

    # Move focus with mainMod + arrow keys
    bind = $meh, SPACE, cyclenext
    bind = $meh, ESCAPE, exec, ~/.config/hypr/scripts/swap-window.sh

    # Group
    bind = $hyper, SPACE, changegroupactive
    bind = $hyper, ESCAPE, exec, ~/.config/hypr/scripts/toggle-group.sh

    # Switch workspaces with mainMod + [0-9]
    bind = $meh, H, workspace, 1
    bind = $meh, J, workspace, 2
    bind = $meh, K, workspace, 3
    bind = $meh, L, workspace, 4
    bind = $meh, N, workspace, 5
    bind = $meh, M, workspace, 6
    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $hyper, H, movetoworkspace, 1
    bind = $hyper, J, movetoworkspace, 2
    bind = $hyper, K, movetoworkspace, 3
    bind = $hyper, L, movetoworkspace, 4
    bind = $hyper, N, movetoworkspace, 5
    bind = $hyper, M, movetoworkspace, 6

    # Special workspace
    bind = $meh, RETURN, togglespecialworkspace, scratchpad
    bind = $hyper, RETURN, movetoworkspace, special:scratchpad
    bind = $meh, G, exec, ~/.config/hypr/scripts/game-mode.sh
    bind = $hyper, G, exec, rm -rf ~/.cache/gamemode && notify-send "Game Mode" "File Deleted" -u low
    bind = $meh, T, togglespecialworkspace, gamespace
    bind = $hyper, T, movetoworkspace, special:gamespace

    # Scroll through existing workspaces with $meh + scroll
    bind = $meh, mouse_down, workspace, e+1
    bind = $meh, mouse_up, workspace, e-1

    # Toggle Float
    bind = $meh, F, togglefloating
    bind = $meh, F, centerwindow, 1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $meh, mouse:272, movewindow
    bindm = $meh, mouse:273, resizewindow

    # Media key
    bindel = , XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%
    bindel = , XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%

    # Requires playerctl
    bind = , XF86AudioPlay, exec, ~/.config/hypr/scripts/playerctl/player-toggle.sh
    bind = , XF86AudioMute, exec, ~/.config/hypr/scripts/playerctl/playerctl.sh
    bind = , XF86AudioPrev, exec, ~/.config/hypr/scripts/playerctl/player-seek.sh -5
    bind = , XF86AudioNext, exec, ~/.config/hypr/scripts/playerctl/player-seek.sh +5
    bindo = , XF86AudioPrev, exec, ~/.config/hypr/scripts/playerctl/player-skip.sh previous
    bindo = , XF86AudioNext, exec, ~/.config/hypr/scripts/playerctl/player-skip.sh next

    # Zoom
    bind = $hyper, mouse_down, exec, current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2;}') && hyprctl keyword cursor:zoom_factor $(echo "$current + 0.5"|bc)
    bind = $hyper, mouse_up, exec, current=$(hyprctl getoption cursor:zoom_factor | head -n 1 | awk '{print $2;}') && hyprctl keyword cursor:zoom_factor $(echo "$current - 0.5"|bc)
    bind = $hyper, mouse:272, exec, hyprctl keyword cursor:zoom_factor 2
    bind = $hyper, mouse:273, exec, hyprctl keyword cursor:zoom_factor 1

    # DN origin
    bind = SUPER + ALT, D, exec, pkill DNOrigins; pkill bottles
  '';
}
