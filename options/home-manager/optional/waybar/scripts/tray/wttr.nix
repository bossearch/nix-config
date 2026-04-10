{
  homes,
  hosts,
  lib,
  ...
}: {
  home.file.".config/waybar/scripts/tray/wttr.sh" = lib.mkIf homes.waybar {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      CACHE_DIR="$HOME/.cache/${hosts.username}"
      COORD_FILE="$CACHE_DIR/coordinate"
      WTTR_FILE="$CACHE_DIR/wttr.json"

      read -r LAT LON < <(awk -F': ' '
        /^Longitude/ { lon=$2 }
        /^Latitude/  { lat=$2 }
        END { print lat, lon }
      ' "$COORD_FILE")

      get_weather_json=$(curl -s "https://wttr.in/''${LAT},''${LON}?format=j1")

      if [[ -n $get_weather_json ]]; then
        echo "$get_weather_json" >"$WTTR_FILE"
        weather_json=$(cat "$WTTR_FILE")
      else
        if [[ ! -f $WTTR_FILE ]]; then
          echo "{\"text\": \" ⛓️‍💥 \"}"
          exit 0
        else
          weather_json=$(cat "$WTTR_FILE")
        fi
      fi

      declare -A WEATHER_CODES=(
        ["113"]="☀️" ["116"]="⛅️" ["119"]="☁️" ["122"]="☁️" ["143"]="🌫"
        ["176"]="🌦" ["179"]="🌧" ["182"]="🌧" ["185"]="🌧" ["200"]="⛈"
        ["227"]="🌨" ["230"]="❄️" ["248"]="🌫" ["260"]="🌫" ["263"]="🌦"
        ["266"]="🌦" ["281"]="🌧" ["284"]="🌧" ["293"]="🌦" ["296"]="🌦"
        ["299"]="🌧" ["302"]="🌧" ["305"]="🌧" ["308"]="🌧" ["311"]="🌧"
        ["314"]="🌧" ["317"]="🌧" ["320"]="🌨" ["323"]="🌨" ["326"]="🌨"
        ["329"]="❄️" ["332"]="❄️" ["335"]="❄️" ["338"]="❄️" ["350"]="🌧"
        ["353"]="🌦" ["356"]="🌧" ["359"]="🌧" ["362"]="🌧" ["365"]="🌧"
        ["368"]="🌨" ["371"]="❄️" ["374"]="🌧" ["377"]="🌧" ["386"]="⛈"
        ["389"]="🌩" ["392"]="⛈" ["395"]="❄️"
      )

      current_code=$(jq -r '.current_condition[0].weatherCode' <<<"$weather_json")
      current_desc=$(jq -r '.current_condition[0].weatherDesc[0].value' <<<"$weather_json")
      current_humi=$(jq -r '.current_condition[0].humidity' <<<"$weather_json")
      current_temp=$(jq -r '.current_condition[0].FeelsLikeC' <<<"$weather_json")
      current_wind=$(jq -r '.current_condition[0].windspeedKmph' <<<"$weather_json")
      current_moon=$(jq -r '.weather[0].astronomy[0].moon_phase' <<<"$weather_json")

      text="''${WEATHER_CODES[$current_code]} ''${current_temp}°"

      moon_icon() {
        case "$1" in
        "New Moon") echo "🌑 New Moon" ;;
        "Waxing Crescent") echo "🌒 Waxing Crescent" ;;
        "First Quarter") echo "🌓 First Quarter" ;;
        "Waxing Gibbous") echo "🌔 Waxing Gibbous" ;;
        "Full Moon") echo "🌕 Full Moon" ;;
        "Waning Gibbous") echo "🌖 Waning Gibbous" ;;
        "Last Quarter") echo "🌗 Last Quarter" ;;
        "Waning Crescent") echo "🌘 Waning Crescent" ;;
        *) echo "🌙 Unknown" ;;
        esac
      }
      moon=$(moon_icon "$current_moon")
      tooltip="<b>''${current_desc} $(jq -r '.current_condition[0].temp_C' <<<"$weather_json")°</b> \
      (Feels like: ''${current_temp}°)\\n\
      Wind: ''${current_wind}Km/h\\n\
      Humidity: ''${current_humi}%\\n\
      Moonphase: ''${moon}\\n"

      days=$(jq -c '.weather[]' <<<"$weather_json")
      i=0

      format_hour() {
        local t=$1
        printf "%02d" $((t / 100))
      }

      to_24h() {
        date -d "$1" +"%H:%M"
      }

      format_chances() {
        local hour_json="$1"
        declare -A chance_map=(
          ["chanceofrain"]="Rainy"
          ["chanceofsunshine"]="Clear"
        )
        local out=()
        local val
        for k in "''${!chance_map[@]}"; do
          val=$(jq -r ".''${k}" <<<"$hour_json")
          ((val > 0)) && out+=("''${val}% ''${chance_map[$k]}")
        done
        echo "''${out[*]}"
      }

      while read -r day; do
        date=$(jq -r '.date' <<<"$day")
        sunrise_raw=$(jq -r '.astronomy[0].sunrise' <<<"$day")
        sunset_raw=$(jq -r '.astronomy[0].sunset' <<<"$day")
        sunrise=$(to_24h "$sunrise_raw")
        sunset=$(to_24h "$sunset_raw")

        feels_list=$(jq -r '.hourly[].FeelsLikeC' <<<"$day")
        maxfeels=$(echo "$feels_list" | sort -nr | head -n1)
        minfeels=$(echo "$feels_list" | sort -n | head -n1)

        maxtemp=$(jq -r '.maxtempC' <<<"$day")
        mintemp=$(jq -r '.mintempC' <<<"$day")

        [[ $i -eq 0 ]] && tooltip+="\n<b>Today, $date</b>\n"
        [[ $i -eq 1 ]] && tooltip+="\n<b>Tomorrow, $date</b>\n"
        [[ $i -gt 1 ]] && tooltip+="\n<b>$date</b>\n"
        tooltip+="⬇️ $mintemp° ($minfeels°) ⬆️ $maxtemp° ($maxfeels°) 🌅 $sunrise 🌇 $sunset\n"

        while read -r hour; do
          time=$(format_hour "$(jq -r '.time' <<<"$hour")")
          ((i == 0 && $((10#$time)) < $((10#$(date +%H))) - 2)) && continue
          hour_code=$(jq -r '.weatherCode' <<<"$hour")
          tempC=$(jq -r '.tempC' <<<"$hour")°
          feels=$(jq -r '.FeelsLikeC' <<<"$hour")
          chances=$(format_chances "$hour")
          [[ -n "$chances" ]] && chances="• $chances"

          tooltip+="$time.00 • ''${WEATHER_CODES[$hour_code]} • ''${tempC} (''${feels}°) ''${chances}\n"
        done <<<"$(jq -c '.hourly[]' <<<"$day")"

        ((i++))
      done <<<"$days"

      echo "{\"text\": \"$text\", \"tooltip\": \"<span foreground=\\\"#DFDFDF\\\">$tooltip</span>\"}"
    '';
  };
}
