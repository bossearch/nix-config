{
  home.file.".config/zk/templates/main.md" = {
    text = ''
      ---
      name: {{format-date now "%d"}}{{id}}-{{slug title}}
      date: {{format-date now "%Y-%m-%d"}}
      time: {{format-date now "%H:%M:%S %z"}}
      tags: []
      ---

      # {{#sh "awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' | tr -d '\n'"}}{{title}}{{/sh}}

      {{content}}
    '';
  };
}
