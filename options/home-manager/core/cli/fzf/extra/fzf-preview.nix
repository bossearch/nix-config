{
  home.file.".config/fzf/extra/fzf-preview.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      file=''${1/#\~\//$HOME}

      center=0
      if [[ ! -r $file ]]; then
        if [[ $file =~ ^(.+):([0-9]+)\ *$ ]] && [[ -r ''${BASH_REMATCH[1]} ]]; then
          file=''${BASH_REMATCH[1]}
          center=''${BASH_REMATCH[2]}
        elif [[ $file =~ ^(.+):([0-9]+):[0-9]+\ *$ ]] && [[ -r ''${BASH_REMATCH[1]} ]]; then
          file=''${BASH_REMATCH[1]}
          center=''${BASH_REMATCH[2]}
        fi
      fi

      if [[ ! -e "$file" ]]; then
        printf "\e[1;31mCannot preview not a file\e[0m\n"
        exit
      fi

      if [[ -d "$file" ]]; then
        if command -v eza > /dev/null; then
          eza --tree --level=2 --all --icons=always --color=always "$file" | head -200
        else
          ls -la "$file" | head -200
        fi
        exit
      fi

      type=$(file --brief --dereference --mime -- "$file")

      if [[ $type =~ application/(zip|x-tar|x-bzip2|x-7z-compressed|x-rar|x-xz|zstd|java-archive) ]]; then
        if command -v ouch > /dev/null; then
          ouch list "$file"
        else
          # fallback if ouch not installed
          echo "Archive file:"
          file "$file"
        fi
        exit
      fi

      if [[ ! $type =~ image/ ]]; then
        if [[ $type =~ =binary ]]; then
          file "$file"
          exit
        fi

        if command -v batcat > /dev/null; then
          batname="batcat"
        elif command -v bat > /dev/null; then
          batname="bat"
        else
          cat "$file"
          exit
        fi

        ''${batname} \
          --style="''${BAT_STYLE:-numbers}" \
          --color=always \
          --pager=never \
          --line-range=:500 \
          --highlight-line="''${center:-0}" \
          -- "$file"

        exit
      fi

      dim=''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}

      if [[ $dim == x ]]; then
        dim=$(stty size < /dev/tty | awk '{print $2 "x" $1}')
      elif ! [[ $KITTY_WINDOW_ID ]] && ((FZF_PREVIEW_TOP + FZF_PREVIEW_LINES == $(stty size < /dev/tty | awk '{print $1}'))); then
        dim=''${FZF_PREVIEW_COLUMNS}x$((FZF_PREVIEW_LINES - 1))
      fi

      if [[ $KITTY_WINDOW_ID ]] || [[ $GHOSTTY_RESOURCES_DIR ]] && command -v kitten > /dev/null; then
        kitten icat --clear --transfer-mode=memory --unicode-placeholder \
          --stdin=no --place="$dim@0x0" "$file" \
          | sed '$d' \
          | sed $'$s/$/\e[m/'

      # just in case i want use sixel with auto detect width for image preview, add this to .zshrc
      # `printf "\e[16t" && read -r -s -dt RESP && echo "''${RESP##*;}" >file/to/store`
      #
      # elif command -v img2sixel > /dev/null; then
      #   CACHE_FILE=file/to/store
      #   multiplier=$(cat "$CACHE_FILE")
      #   width=$(( (FZF_PREVIEW_COLUMNS) * multiplier))
      #   img2sixel -q low -p 32 -r nearest -w "$width" "$file"
      #   echo

      elif command -v chafa > /dev/null; then
        chafa -s "$dim" "$file"
        echo
      elif command -v imgcat > /dev/null; then
        imgcat -W "''${dim%%x*}" -H "''${dim##*x}" "$file"
      else
        file "$file"
      fi
    '';
  };
}
