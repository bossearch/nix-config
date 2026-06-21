{
  mylib,
  pkgs,
  ...
}: {
  imports = mylib.autoimport ./.;
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    settings = {
      accessible_colors = "disabled";
      accessible_prompter = "disabled";
      aliases = {
        co = "pr checkout";
      };
      browser = "";
      color_labels = "disabled";
      editor = "";
      git_protocol = "https";
      http_unix_socket = "";
      pager = "";
      prefer_editor_prompt = "disabled";
      prompt = "enabled";
      spinner = "enabled";
    };
    extensions = with pkgs; [
      gh-markdown-preview
      gh-notify
      gh-token
    ];
  };
}
