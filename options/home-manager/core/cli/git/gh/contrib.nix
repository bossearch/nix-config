{
  config,
  hosts,
  ...
}: {
  home.file.".config/gh/gh-contrib.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -euo pipefail

      gh api graphql -f query='{
        viewer {
          contributionsCollection {
            contributionCalendar {
              weeks {
                contributionDays {
                  color
                }
              }
            }
          }
        }
      }' --jq '.data.viewer.contributionsCollection.contributionCalendar.weeks[-26:] | .[] .contributionDays[] .color' |
        grep . >${config.xdg.cacheHome}/${hosts.username}/gh-contrib
    '';
  };
}
