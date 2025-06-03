{
  fsys = ''
    function _help
        echo "
        Usage: fsys [options]
        Utility for using systemctl interactively via fzf.
        If no options are given, fully interactive mode is launched with system service units being used.
            -u          : work with --user services
            --start     : systemctl start <unit>
            --stop      : systemctl stop <unit>
            --restart   : systemctl restart <unit>
            --status    : systemctl status <unit>
            --edit      : systemctl edit --full <unit>
            --enable    : systemctl enable --now <unit>
            --disable   : systemctl disable --now <unit>
            --journal   : systemctl journal <unit>
            --help      : print this message and exit

        Examples:
            fsys -u --edit    : edit a user service
            fsys --start      : start a system service
        "
    end

    function preview_service --argument mode
        awk '{print $1}' | fzf --multi --ansi --preview="SYSTEMD_COLORS=1 systemctl $mode -n 30 status --no-pager {}"
    end

    function _sudo
        set -l mode $argv[1]
        set -e argv[1]
        if test "$mode" = --system
            command sudo $argv
        else if test "$mode" = --user
            command $argv
        end
    end

    function interactive
        set action (printf "\033[0;32mstart\033[0m\n\033[0;31mstop\033[0m\n\033[0;37mrestart\033[0m\n\033[0;37mstatus\033[0m\n\033[0;37medit\033[0m\n\033[0;32menable\033[0m\n\033[0;31mdisable\033[0m\n\033[0;36mjournal\033[0m" | fzf --reverse --ansi --prompt="Select systemctl mode:")
        switch (string trim -- $action)
            case start
                sysstart
            case stop
                sysstop
            case restart
                sysrestart
            case status
                sysstatus
            case edit
                sysedit
            case enable
                sysenable
            case journal
                journalf
            case disable
                sysdisable
        end
    end

    function sysstart
        systemctl $mode list-unit-files --no-legend --type=service | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode systemctl $mode start $unit
                    systemctl $mode -n20 status $unit --no-pager
                end
            end
        end
    end

    function sysstop
        systemctl $mode list-units --no-legend --type=service --state=running | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode systemctl $mode stop $unit
                    systemctl $mode -n20 status $unit --no-pager
                end
            end
        end
    end

    function sysrestart
        systemctl $mode list-unit-files --no-legend --type=service | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode systemctl $mode restart $unit
                    systemctl $mode -n20 status $unit --no-pager
                end
            end
        end
    end

    function sysstatus
        systemctl $mode list-unit-files --no-legend --type=service | preview_service $mode | while read -l unit
            if test -n "$unit"
                systemctl $mode -n20 status $unit --no-pager
            end
        end
    end

    function sysedit
        set units (systemctl $mode list-unit-files --no-legend --type=service | preview_service $mode)
        if test -n "$units"
            _sudo $mode systemctl $mode edit --full $units
        end
    end

    function sysenable
        systemctl $mode list-unit-files --no-legend --type=service --state=disabled | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode systemctl $mode enable --now $unit
                    systemctl $mode -n20 status $unit --no-pager
                end
            end
        end
    end

    function sysdisable
        systemctl $mode list-unit-files --no-legend --type=service --state=enabled | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode systemctl $mode disable --now $unit
                    systemctl $mode -n20 status $unit --no-pager
                end
            end
        end
    end

    function journalf
        systemctl $mode list-units --no-legend --type=service --state=running | preview_service $mode | while read -l unit
            if test -n "$unit"
                if _sudo $mode journalctl $mode -u $unit -f
                    journalctl $mode -n20 -u $unit -f --no-pager
                end
            end
        end
    end

    # Parse options
    set -g mode --system
    argparse u start stop restart status edit enable disable journal h/help -- $argv
    or begin
        _help
        return 1
    end

    if set -q _flag_u
        set -g mode --user
    end

    if set -q _flag_start
        sysstart
        return
    else if set -q _flag_stop
        sysstop
        return
    else if set -q _flag_restart
        sysrestart
        return
    else if set -q _flag_status
        sysstatus
        return
    else if set -q _flag_edit
        sysedit
        return
    else if set -q _flag_enable
        sysenable
        return
    else if set -q _flag_disable
        sysdisable
        return
    else if set -q _flag_journal
        journalf
        return
    else if set -q _flag_h; or set -q _flag_help
        _help
        return
    end

    interactive
  '';
}
