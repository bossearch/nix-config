{
  home.file.".config/fish/functions/__fzf_complete.fish".text = ''
    function __fzf_complete
        set -l cmd (commandline -co) (commandline -ct)
        switch $cmd[1]
            case env sudo
                for i in (seq 2 (count $cmd))
                    switch $cmd[$i]
                        case '-*'
                        case '*=*'
                        case '*'
                            set cmd $cmd[$i..-1]
                            break
                    end
                end
        end
        set -l cmd_lastw $cmd[-1]
        set cmd (string join -- ' ' $cmd)

        set -l fzf_query ''\''

        # 1. Get completions and transform ONLY the completion part
        set -l raw_complist (complete -C$cmd)
        test -z "$raw_complist"; and return
        set -l tab "	"  # Real tab character (paste with Ctrl+V then Tab)

        set -l complist
        for c in $raw_complist
            set -l parts (string split -m 1 "$tab" -- $c)
            set -l val $parts[1]
            set -l desc (string join "$tab" $parts[2..-1])
            if string match -q "* *" -- $val; and not string match -q "'*'" -- $val
                  if string match -q -- "*'*" "$val"  # Contains single quote?
                      set val "\"$val\""  # Use double quotes
                  else
                      set val "'$val'"  # Use single quotes
                  end
              end
            set complist $complist "$val$tab$desc"
        end

        # 2. Handle single result
        if test (count $complist) -eq 1
            set -l result (string replace -r '\t.*$' ''\'' -- $complist[1])
            __fzf_complete_apply "$result"
            return
        end

        # 3. Multiple options
        set -l query
        set -l result
        string join \n $complist \
        | eval (__fzfcmd) (string escape --no-quoted -- $fzf_query) --print-query (__fzf_complete_opts) \
        | while read -l r
            if test -z "$query"
                set query $r
            else
                set -l cleaned (string replace -r '\t.*$' ''\'' -- $r)
                set result $result $cleaned
            end
        end

        if test -z "$query" -a -z "$result"
            commandline -f repaint
            return
        end

        test -z "$result"; and set result $query

        for i in (seq (count $result))
            __fzf_complete_apply $result[$i]
            if test $i -lt (count $result)
                commandline -i ' '
            end
        end
    end

    function __fzf_complete_apply -a result
        commandline -t ""
        commandline -t -- $result
        commandline -f repaint
    end

    function __fzf_complete_opts
        set -l file (status -f)
        echo $FZF_DEFAULT_OPTS
        echo --bind tab:down,btab:up
        echo --no-multi
        echo --delimiter='\\t' --with-nth=1 --preview-window=right --preview="fish\ '$file'\ __fzf_complete_preview\ '{1}'\ '{2..}'"
    end

    function __fzf_complete_preview
        set -l path (string replace "~" $HOME -- $argv[1])
        if test -d "$path"
            eval $FZF_PREVIEW_DIR_CMD (string escape $path)
        else if test -f "$path"
            if grep -qI . "$path" 2>/dev/null
                eval $FZF_PREVIEW_FILE_CMD (string escape $path)
            end
        end
        type -q "$path" 2>/dev/null; and type -a "$path"
        echo $argv[2]
    end

    test "$argv[1]" = "__fzf_complete_preview"; and __fzf_complete_preview $argv[2..3]
  '';
}
