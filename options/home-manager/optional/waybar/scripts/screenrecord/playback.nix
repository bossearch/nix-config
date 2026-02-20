{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/screenrecord/playback.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      tmpfile=$(mktemp)
      CURRENT_SOURCE=$(pactl get-default-source)
      SOURCE_STATUS=$(pactl get-source-mute "$CURRENT_SOURCE" 2>/dev/null |
        awk '{if ($2 == "yes") print "Inactive"; \
              else if ($2 == "no") print "Active"; \
              else print "Unknown"}')
      CURRENT_SINK=$(pactl get-default-sink)
      SINK_STATUS=$(pactl get-sink-mute "$CURRENT_SINK" 2>/dev/null |
        awk '{if ($2 == "yes") print "Inactive"; \
              else if ($2 == "no") print "Active"; \
              else print "Unknown"}')

      # Collect sink input details
      pactl list sink-inputs | awk '
        /^Sink Input #/ {id=$3}
        /media.name =/ {media=substr($0, index($0,$3))}
        /node.name =/ {node=substr($0, index($0,$3)); gsub(/"/, "", media); gsub(/"/, "", node); print id, node, media}
      ' >"$tmpfile"

      column0=()
      column1=()
      column2=()
      column3=()

      while IFS= read -r line; do
        id=$(echo "$line" | awk '{gsub(/^#/, "", $1); print $1}')
        node=$(echo "$line" | awk '{print $2}')
        media="''${line#* * }"

        column0+=()
        column1+=("$id")
        column2+=("$node")
        column3+=("$media")
      done <"$tmpfile"

      column1+=("SINK")
      column2+=("$SINK_STATUS")
      column3+=("$CURRENT_SINK")
      column1+=("SOURCE")
      column2+=("$SOURCE_STATUS")
      column3+=("$CURRENT_SOURCE")

      zenity_data=()
      for ((i = 0; i < ''${#column1[@]}; i++)); do
        zenity_data+=("''${column0[$i]}" "''${column1[$i]}" "''${column2[$i]}" "''${column3[$i]}")
      done

      # zenity
      ID=$(zenity --list \
        --title="Playback Streams" \
        --column=" " --column="ID" --column="Node" --column="Media" \
        --hide-column=2 \
        --width=600 --height=400 \
        --cancel-label="Cancel" \
        --ok-label="Record" --checklist --multiple \
        "''${zenity_data[@]}")

      BUTTON=$?

      rm "$tmpfile"

      # validate selections
      IFS='|' read -r -a selections <<<"$ID"

      has_sink_input=false
      has_sink=false
      has_source=false
      sink_input_count=0

      for id in "''${selections[@]}"; do
        if [[ "$id" =~ ^[0-9]+$ ]]; then
          has_sink_input=true
          ((sink_input_count++))
        elif [[ "$id" == "SINK" ]]; then
          has_sink=true
        elif [[ "$id" == "SOURCE" ]]; then
          has_source=true
        fi
      done

      if ((sink_input_count > 1)); then
        zenity --error \
          --title="Invalid Selection" \
          --text="You can only select one sink-input at a time."
        exec "$0"
      elif $has_sink_input && $has_sink; then
        zenity --error \
          --title="Invalid Selection" \
          --text="You cannot select both sink-input(s) and the default SINK.\nPlease choose one or the other."
        exec "$0"
      elif ! $has_sink_input && ! $has_sink && ! $has_source && [[ "$BUTTON" -eq 0 ]]; then
        ID="unselected"
        BUTTON="0"
      fi

      # handle selections
      VIRTUAL_SINK=wl-screenrec
      DEFAULT_SINK=$(pactl get-default-sink)
      DEFAULT_SOURCE=$(pactl get-default-source)

      if ! pactl list short modules | grep -q "$VIRTUAL_SINK"; then
        pactl load-module module-null-sink media.class=Audio/Sink sink_name="$VIRTUAL_SINK" channel_map=stereo
      fi

      for id in "''${selections[@]}"; do
        COMMAND="--audio --audio-device wl-screenrec.monitor"
        if [[ "$id" =~ ^[0-9]+$ ]]; then
          pactl load-module module-combine-sink sink_name=dual-out slaves="$DEFAULT_SINK,$VIRTUAL_SINK" &>/dev/null
          sleep 1
          pactl move-sink-input "$ID" dual-out
        elif [[ "$id" == "SINK" ]]; then
          echo "$DEFAULT_SINK" >"$HOME/.cache/${hosts.username}/default-sink"
          pactl load-module module-combine-sink \
            sink_name=dual-out \
            slaves="$DEFAULT_SINK,$VIRTUAL_SINK" &>/dev/null
          pactl set-default-sink dual-out
        elif [[ "$id" == "SOURCE" ]]; then
          pactl load-module module-loopback source="$DEFAULT_SOURCE" sink="$VIRTUAL_SINK" &>/dev/null
        fi
      done

      echo "$BUTTON $COMMAND"
    '';
  };
}
