{
  fsys = ''
    function _build_cmd --argument mode action unit
        set -l prefix ""
        test "$mode" = "--system"; and set prefix "sudo "

        switch $action
            case journal;        echo "$prefix""journalctl $mode -u $unit -f"
            case enable disable; echo "$prefix""systemctl $mode $action --now $unit"
            case '*';            echo "$prefix""systemctl $mode $action $unit"
        end
    end

    function sysrun --argument mode action
        set -l list_cmd ""
        switch $action
            case start;   set list_cmd "systemctl $mode list-units --type=service --all --state=inactive,failed --plain"
            case stop;    set list_cmd "systemctl $mode list-units --type=service --state=active,running --plain"
            case enable;  set list_cmd "systemctl $mode list-unit-files --type=service --state=disabled"
            case disable; set list_cmd "systemctl $mode list-unit-files --type=service --state=enabled"
            case '*';     set list_cmd "systemctl $mode list-units --type=service --all --plain"
        end

        set -l units (eval $list_cmd --no-legend | awk '{print $1}' | string match -r '.*\.service' | fzf --multi --ansi --reverse \
            --preview="SYSTEMD_COLORS=1 systemctl $mode status {} --no-pager" \
            | string trim)

        if test -n "$units"
            _build_cmd $mode $action $units
        end
    end

    set -g mode --system
    argparse u start stop restart status enable disable journal -- $argv; or return 1
    if set -q _flag_u; set -g mode --user; end

    set -l final_cmd ""

    if set -q _flag_status;       set final_cmd (sysrun $mode status)
    else if set -q _flag_restart; set final_cmd (sysrun $mode restart)
    else if set -q _flag_start;   set final_cmd (sysrun $mode start)
    else if set -q _flag_stop;    set final_cmd (sysrun $mode stop)
    else if set -q _flag_enable;  set final_cmd (sysrun $mode enable)
    else if set -q _flag_disable; set final_cmd (sysrun $mode disable)
    else if set -q _flag_journal; set final_cmd (sysrun $mode journal)
    else
        set -l action (printf "\033[0;33mstatus\033[0m\n\033[0;33mrestart\033[0m\n\033[0;32mstart\033[0m\n\033[0;31mstop\033[0m\n\033[0;32menable\033[0m\n\033[0;31mdisable\033[0m\n\033[0;36mjournal\033[0m" | fzf --reverse --ansi --prompt="Select action: ")
        test -n "$action"; and set final_cmd (sysrun $mode (string trim $action))
    end

    if test -n "$final_cmd"
        commandline -r "$final_cmd"
        commandline -f repaint
        commandline -f execute
    else
        commandline -f repaint
    end
  '';
}
