{
  home.file.".config/hypr/scripts/deepl-terjemah.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      # Define your DeepL API key
      API_KEY=$(cat /home/bosse/Documents/obsidian-vault/05\ -\ Permanent/deepl-api.md)

      # Get the selected text from the Wayland clipboard
      text=$(wl-paste -p)

      # Check if clipboard is empty
      if [ -z "$text" ]; then
        notify-send -a "deepl-translate" "Error" "Clipboard is empty!" -u critical
        exit 1
      fi

      # Prepare the JSON data payload
      json_payload=$(
        cat <<EOF
      {
        "text": ["$text"],
        "target_lang": "ID",
        "source_lang": "EN"
      }
      EOF
      )

      # Send the translation request to DeepL API
      res=$(curl -s -X POST 'https://api-free.deepl.com/v2/translate' \
        --header "Authorization: DeepL-Auth-Key $API_KEY" \
        --header "Content-Type: application/json" \
        --data "$json_payload")

      # Check if API call was successful
      if [ -z "$res" ] || echo "$res" | grep -q '"translations":'; then
        translated_text=$(echo "$res" | grep -Po '"text":"\K.*?(?=")')

        # Show the translated text in a notification
        echo "$translated_text" | wl-copy
        notify-send -a "deepl-translate" "Terjemahan" "Selesai"
      else
        notify-send -a "deepl-translate" "Eror" "Terjemahan Gagal." -u critical
        exit 1
      fi
    '';
  };
}
