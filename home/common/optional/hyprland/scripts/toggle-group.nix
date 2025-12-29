#FIXME: Should combine to grouped window that already exist
#FIXME: Floating window will mess up the nearest window logic
{
  home.file.".config/hypr/scripts/toggle-group.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      WS=$(hyprctl -j activeworkspace | jq -r '.id')

      group_window() {
        hyprctl -j clients |
          jq -r --arg ws "$WS" '
            .[]
            | select(.workspace.id == ($ws|tonumber))
            | select(.grouped | length >= 1)
            | .address'
      }

      ungroup_window() {
        hyprctl -j clients |
          jq -r --arg ws "$WS" '
            .[]
            | select(.workspace.id == ($ws|tonumber))
            | select(.grouped | length < 1)
            | .address'
      }

      ACTIVE=$(hyprctl -j activewindow | jq -r '.address')
      if [[ -z "$ACTIVE" ]]; then
        exit 0
      fi

      GROUP=$(group_window)
      if [[ -z $GROUP ]]; then
        hyprctl dispatch togglegroup
        UNGROUP=$(ungroup_window)
        if [[ -n $UNGROUP ]]; then
          UNGROUP_SUM=$(echo "$UNGROUP" | wc -l)
          for ((i = 1; i <= UNGROUP_SUM; i++)); do
            GROUP_ANCHOR=$(group_window | head -1)

            ANCHOR_POS=$(hyprctl -j clients |
              jq -r --arg addr "$GROUP_ANCHOR" '
              .[] | select(.address == $addr) | .at')

            ANCHOR_X=$(echo "$ANCHOR_POS" | jq '.[0]')
            ANCHOR_Y=$(echo "$ANCHOR_POS" | jq '.[1]')
            UNGROUP_NEAREST=$(
              hyprctl -j clients |
                jq -r --arg ws "$WS" --arg ax "$ANCHOR_X" --arg ay "$ANCHOR_Y" '
                [ .[]
                  | select(.workspace.id == ($ws|tonumber))
                  | select(.grouped | length == 0)
                  | select(.at | length == 2)
                  | . as $win
                  | ($win.at[0] - ($ax|tonumber)) as $dx
                  | ($win.at[1] - ($ay|tonumber)) as $dy
                  | ($dx*$dx + $dy*$dy) as $dist
                  | {addr: $win.address, dist: $dist}
                ]
                | sort_by(.dist)
                | .[0].addr
              '
            )
            #---
            POS=$(hyprctl -j clients | jq -r --arg addr "$UNGROUP_NEAREST" '
            .[] | select(.address == $addr) | .at')

            hyprctl dispatch focuswindow address:"$UNGROUP_NEAREST"
            #---
            X=$(echo "$POS" | jq '.[0]')
            Y=$(echo "$POS" | jq '.[1]')

            echo "$ANCHOR_X:$X | $ANCHOR_Y:$Y"
            if ((X < ANCHOR_X)); then
              DIR="r"
            elif ((X > ANCHOR_X)); then
              DIR="l"
            elif ((Y < ANCHOR_Y)); then
              DIR="d"
            else
              DIR="u"
            fi
            hyprctl dispatch moveintogroup "$DIR"
          done
          while true; do
            ACTIVE_NEW=$(hyprctl -j activewindow | jq -r '.address')
            if [[ "$ACTIVE_NEW" != "$ACTIVE" ]]; then
              hyprctl dispatch changegroupactive f
            else
              break
            fi
          done
        else
          exit 0
        fi
      else
        hyprctl dispatch togglegroup
      fi
    '';
  };
}
