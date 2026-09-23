{
  config,
  pkgs,
  ...
}: let
  noteDir = "${config.programs.zk.settings.notebook.dir}";

  script = ''
    NOTES_DIR="${noteDir}"
    MESSAGES="$(date '+%Y-%m-%d %H:%M:%S')"

    if [[ ! -d "$NOTES_DIR" ]]; then
      echo -e "\033[31mCan't sync notes: directory '$NOTES_DIR' does not exist.\033[0m"
      exit 1
    fi

    pushd "$NOTES_DIR" >/dev/null || exit 1

    git diff -U0 --no-prefix '*.*' ':!.zk/*' ':!.obsidian/*' | rg '^(?:diff --git |(?:\+[^+]|-[^-]))' | sed -E \
      -e 's/^(diff --git .*)/\n\x1b[1m\1\x1b[0m/' \
      -e 's/^(\+)(.*)/\x1b[32m+\2\x1b[0m/' \
      -e 's/^(-)(.*)/\x1b[31m-\2\x1b[0m/'

    echo ""
    git status --short '*.*' ':!.zk/*' ':!.obsidian/*'

    trap 'tput cnorm; echo -e "\nAborted by user."; exit 1' SIGINT

    echo ""
    read -r -p "Are you sure you want to sync your notes? (y/N): " confirm

    confirm="''${confirm:-n}"

    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
      echo "Cancelled."
      popd >/dev/null
      exit 0
    fi

    echo ""

    git add -- '*.*'

    if git diff --staged --quiet; then
      echo "No changes to commit."
    else
      git commit -m "$MESSAGES"
      git push
      echo -e "\e[32mDone\e[0m - \e[1m$MESSAGES\e[0m"
    fi

    popd >/dev/null
  '';
in {
  home.packages = [
    (pkgs.writeShellScriptBin "notesync" script)
  ];
}
