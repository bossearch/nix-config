{
  fkill = ''
    set -l signal 9
    if test (count $argv) -gt 0
        set signal $argv[1]
    end

    set -l pid
    if test (id -u) -ne 0
        set pid (ps -f -u (id -u) | sed 1d | fzf -m | awk '{print $2}')
    else
        set pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    end

    if test -n "$pid"
        echo $pid | xargs kill -$signal
    end
  '';
}
