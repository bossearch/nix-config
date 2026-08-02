{
  home.file.".config/zk/templates/main.md" = {
    text = ''
      ---
      name: {{id}}-{{slug title}}
      date: {{format-date now "%Y-%m-%d"}}
      time: {{format-date now "%H:%M:%S %z"}}
      tags: []
      ---

      # {{title}}

      {{content}}
    '';
  };
}
