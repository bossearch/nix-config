{builtins}:
builtins.toFile "senior.fish" ''
  function __senior_subcommand
      set -l tokens (commandline -opc)
      set -l skip_next 0
      for t in $tokens
          if test $skip_next -eq 1
              set skip_next 0
              continue
          end
          # Ignore store flags
          if test $t = "-s"
              set skip_next 1
              continue
          end
          if test $t = "--store"
              set skip_next 1
              continue
          end
          switch $t
              case init clone edit show mv rm menu print-dir git add-recipient reencrypt change-passphrase grep cat unlock agent help
                  return 1
          end
      end
      return 0
  end

  function __senior_complete_entries_with_subdirs
      set -l store_flag
      set -l store_val
      set -l tokens (commandline -opc)
      for i in (seq 1 (count $tokens))
          set token $tokens[$i]
          switch "$token"
              case "-s" "--store"
                  if test (math $i + 1) -le (count $tokens)
                      set store_flag $token
                      set store_val $tokens[(math $i + 1)]
                  end
                  break
              case "-s*"
                  set store_flag "-s"
                  set store_val (string sub -s 3 -- "$token")
                  break
              case "--store=*"
                  set store_flag "--store"
                  set store_val (string replace -r '^--store=' "" -- "$token")
                  break
          end
      end

      set -l cmd senior
      if set -q store_val[1]
          set cmd $cmd $store_flag "$store_val"
      end
      set cmd $cmd print-dir
      set -l prefix (eval "$cmd" 2>/dev/null | head -n1 | string trim)
      if not test -d "$prefix"
          return
      end

      set -l search_term (commandline --current-token | string replace -r '^~' "$HOME")
      find -L "$prefix" \
          \( -name '.*' \) -prune -o \
          \( -type f -name '*.age' -print -o -type d -print \) \
          2>/dev/null \
          | while read -l file
              set rel_path (string replace -r "^$prefix/*" "" -- "$file")
              if string match -q -e '*.age' -- "$rel_path"
                  string replace -r '\.age$' "" -- "$rel_path"
              else
                  echo "$rel_path/"
              end
          end \
          | string match -a -- "$search_term*"
  end

  function __senior_complete_entries
      set -l store_flag
      set -l store_val
      set -l tokens (commandline -opc)
      for i in (seq 1 (count $tokens))
          set token $tokens[$i]
          switch "$token"
              case "-s" "--store"
                  if test (math $i + 1) -le (count $tokens)
                      set store_flag $token
                      set store_val $tokens[(math $i + 1)]
                  end
                  break
              case "-s*"
                  set store_flag "-s"
                  set store_val (string sub -s 3 -- "$token")
                  break
              case "--store=*"
                  set store_flag "--store"
                  set store_val (string replace -r '^--store=' "" -- "$token")
                  break
          end
      end

      set -l cmd senior
      if set -q store_val[1]
          set cmd $cmd $store_flag "$store_val"
      end
      set cmd $cmd print-dir
      set -l prefix (eval "$cmd" 2>/dev/null | head -n1 | string trim)
      if not test -d "$prefix"
          return
      end

      set -l search_term (commandline --current-token | string replace -r '^~' "$HOME")
      find -L "$prefix" \
          \( -name '.*' \) -prune -o \
          \( -type f -name '*.age' -print \) \
          2>/dev/null \
          | while read -l file
              string replace -r "^$prefix/*" "" -- "$file" | string replace -r '\.age$' ""
          end \
          | string match -a -- "$search_term*"
  end

  function __senior_complete_subdirs
      set -l store_flag
      set -l store_val
      set -l tokens (commandline -opc)
      for i in (seq 1 (count $tokens))
          set token $tokens[$i]
          switch "$token"
              case "-s" "--store"
                  if test (math $i + 1) -le (count $tokens)
                      set store_flag $token
                      set store_val $tokens[(math $i + 1)]
                  end
                  break
              case "-s*"
                  set store_flag "-s"
                  set store_val (string sub -s 3 -- "$token")
                  break
              case "--store=*"
                  set store_flag "--store"
                  set store_val (string replace -r '^--store=' "" -- "$token")
                  break
          end
      end

      set -l cmd senior
      if set -q store_val[1]
          set cmd $cmd $store_flag "$store_val"
      end
      set cmd $cmd print-dir
      set -l prefix (eval "$cmd" 2>/dev/null | head -n1 | string trim)
      if not test -d "$prefix"
          return
      end

      set -l search_term (commandline --current-token | string replace -r '^~' "$HOME")
      find -L "$prefix" \
          \( -name '.*' \) -prune -o \
          \( -type d -print \) \
          2>/dev/null \
          | while read -l file
              set rel_path (string replace -r "^$prefix/*" "" -- "$file")
              if test -n "$rel_path"
                  echo "$rel_path/"
              end
          end \
          | string match -a -- "$search_term*"
  end

  function __senior_complete_stores
      set -l main_dir (command senior print-dir 2>/dev/null | head -n1 | string trim)
      if test -z "$main_dir" -o ! -d "$main_dir"
          return
      end
      set -l parent_dir (dirname "$main_dir")
      if test -z "$parent_dir" -o ! -d "$parent_dir"
          return
      end
      for child in $parent_dir/*/
          if test -d "$child"
              echo (basename $child)
          end
      end
  end

  function __senior_complete_menu_command
      set -l cmd (commandline -opc)
      # Check if we're inside a menu subcommand
      if contains menu $cmd
          # Find if we have an odd number of arguments after menu
          set -l menu_index (count (contains -i menu $cmd))
          set -l args_after_menu (count $cmd) - $menu_index
          if test $args_after_menu -ge 1
              # We have at least one command after menu
              set -l subcommand $cmd[$menu_index+1]
              switch $subcommand
                  case clip type-content
                      # These accept a key argument
                      echo "password" "user" "email" "otp"
                      return
                  case type-text
                      # This accepts arbitrary text, no completion needed
                      return
                  case sleep
                      # This accepts milliseconds
                      return
              end
          end
      end

      # Default menu subcommands
      echo "clip:Add the value to the clipboard"
      echo "type-content:Type the value"
      echo "type-text:Type text"
      echo "sleep:Wait"
  end

  # General Completions
  complete -c senior -n '__senior_subcommand' -a 'init clone edit show mv rm menu print-dir git add-recipient reencrypt change-passphrase grep cat unlock agent help' -f -d 'Subcommand'
  complete -c senior -l help -n '__fish_use_subcommand' -d 'Print help'
  complete -c senior -l version -n '__fish_use_subcommand' -d 'Print version'
  complete -c senior -s h -n '__fish_use_subcommand' -d 'Print help'
  complete -c senior -s V -n '__fish_use_subcommand' -d 'Print version'
  complete -c senior -s s -l store -r -f -n '__fish_use_subcommand' -a '(__senior_complete_stores)' -d 'Store name'

  # init
  complete -c senior -n '__fish_seen_subcommand_from init' -s i -l identity -r -f -d 'Identity file path'
  complete -c senior -n '__fish_seen_subcommand_from init' -s a -l recipient-alias -x -d 'Recipient alias'
  complete -c senior -n '__fish_seen_subcommand_from init' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a init -d 'Initialize new store'

  # clone
  complete -c senior -n '__fish_seen_subcommand_from clone' -s i -l identity -r -f -d 'Identity file path'
  complete -c senior -n '__fish_seen_subcommand_from clone' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from clone' -a '(__fish_complete_urls)' -d 'Git repository URL'
  complete -c senior -n '__fish_use_subcommand' -a clone -d 'Clone store from git repo'

  # edit
  complete -c senior -n '__fish_seen_subcommand_from edit' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from edit' -f -a '(__senior_complete_entries)' -d 'Password name'
  complete -c senior -n '__fish_use_subcommand' -a edit -d 'Edit/create password'

  # show (s)
  complete -c senior -n '__fish_seen_subcommand_from show s' -s k -l key -x -a 'password user email otp' -d 'Show specific key'
  complete -c senior -n '__fish_seen_subcommand_from show s' -s c -l clip -d 'Copy to clipboard'
  complete -c senior -n '__fish_seen_subcommand_from show s' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from show s' -f -a '(__senior_complete_entries)' -d 'Password name'
  complete -c senior -n '__fish_use_subcommand' -a show -d 'Show password'
  complete -c senior -n '__fish_use_subcommand' -a s -d 'Alias for show'

  # mv
  complete -c senior -n '__fish_seen_subcommand_from mv' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from mv' -f -a '(__senior_complete_entries_with_subdirs)' -d 'Source path'
  complete -c senior -n '__fish_seen_subcommand_from mv' -f -a '(__senior_complete_entries_with_subdirs)' -d 'Destination path'
  complete -c senior -n '__fish_use_subcommand' -a mv -d 'Move password'

  # rm
  complete -c senior -n '__fish_seen_subcommand_from rm' -s r -l recursive -d 'Remove directory recursively'
  complete -c senior -n '__fish_seen_subcommand_from rm' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from rm' -f -a '(__senior_complete_entries_with_subdirs)' -d 'Password/directory name'
  complete -c senior -n '__fish_use_subcommand' -a rm -d 'Remove password'

  # menu
  complete -c senior -n '__fish_seen_subcommand_from menu' -l menu-program -x -d 'Menu program to use'
  complete -c senior -n '__fish_seen_subcommand_from menu' -l typing-program -x -d 'Typing program to use'
  complete -c senior -n '__fish_seen_subcommand_from menu' -s d -l key-delay -x -d 'Milliseconds between keystrokes'
  complete -c senior -n '__fish_seen_subcommand_from menu' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from menu' -f -a '(__senior_complete_menu_command)'
  complete -c senior -n '__fish_use_subcommand' -a menu -d 'Launch menu to select/type/clip passwords'

  # print-dir
  complete -c senior -n '__fish_seen_subcommand_from print-dir' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a print-dir -d 'Show store directory'

  # git
  complete -c senior -n '__fish_seen_subcommand_from git' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from git' -f -a 'init push pull config log reflog' -d 'Git command'
  complete -c senior -n '__fish_use_subcommand' -a git -d 'Run git command in store'

  # add-recipient
  complete -c senior -n '__fish_seen_subcommand_from add-recipient' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from add-recipient' -f -d 'Recipient public key'
  complete -c senior -n '__fish_seen_subcommand_from add-recipient' -f -d 'Recipient alias'
  complete -c senior -n '__fish_use_subcommand' -a add-recipient -d 'Add new recipient'

  # reencrypt
  complete -c senior -n '__fish_seen_subcommand_from reencrypt' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a reencrypt -d 'Re-encrypt store'

  # change-passphrase
  complete -c senior -n '__fish_seen_subcommand_from change-passphrase' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a change-passphrase -d 'Change store passphrase'

  # grep
  complete -c senior -n '__fish_seen_subcommand_from grep' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from grep' -r -d 'Pattern or command to search'
  complete -c senior -n '__fish_use_subcommand' -a grep -d 'Search password contents'

  # cat
  complete -c senior -n '__fish_seen_subcommand_from cat' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_seen_subcommand_from cat' -f -a '(__senior_complete_subdirs)' -d 'Directory filter'
  complete -c senior -n '__fish_use_subcommand' -a cat -d 'Show all passwords'

  # unlock
  complete -c senior -n '__fish_seen_subcommand_from unlock' -l check -d 'Check lock status'
  complete -c senior -n '__fish_seen_subcommand_from unlock' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a unlock -d 'Unlock store'

  # agent
  complete -c senior -n '__fish_seen_subcommand_from agent' -l default-cache-ttl -x -d 'Passphrase cache duration in seconds'
  complete -c senior -n '__fish_seen_subcommand_from agent' -s h -l help -d 'Print help'
  complete -c senior -n '__fish_use_subcommand' -a agent -d 'Start agent to cache passphrases'

  # help
  complete -c senior -n '__fish_seen_subcommand_from help' -f -a 'init clone edit show mv rm menu print-dir git add-recipient reencrypt change-passphrase grep cat unlock agent help' -d 'Subcommand to get help for'
  complete -c senior -n '__fish_use_subcommand' -a help -d 'Show command help'
''
