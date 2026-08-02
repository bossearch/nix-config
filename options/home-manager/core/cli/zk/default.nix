{
  config,
  hosts,
  lib,
  ...
}: {
  imports = [./templates];

  programs.zk = {
    enable = true;
    settings = {
      notebook.dir = "${config.home.homeDirectory}/Documents/zettelkasten";
      extra.author = "${hosts.username}";
      note = {
        default-title = "Untitled";
        extension = "md";
        filename = "{{format-date now '%Y/%m/%d/'}}{{id}}-{{slug title}}";
        id-case = "lower";
        id-charset = "alphanum";
        id-length = 4;
        language = "en";
        template = "main.md";
      };
      format.markdown = {
        # disable hastags so zk will not found tags like #hexcolor
        hastags = false;
        link-drop-extension = true;
        # use custom link-format so it still compatible with obsidian
        link-format = "[[{{metadata.name}}]]";
      };

      tool.editor = "nvim";
    };
  };
  home = lib.mkIf config.programs.zk.enable {
    sessionVariables.ZK_NOTEBOOK_DIR = "${config.programs.zk.settings.notebook.dir}";
  };
}
