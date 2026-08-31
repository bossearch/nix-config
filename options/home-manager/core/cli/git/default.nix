{
  config,
  pkgs,
  mylib,
  ...
}: {
  imports = mylib.autoimport ./.;

  programs.git = {
    enable = true;
    package = pkgs.git.override {withLibsecret = true;};
    settings = {
      user = {
        name = "bossearch";
        email = "yudha.bosse@gmail.com";
      };
      credential.helper = "libsecret";
      alias = {
        copydiff = "!{ echo '```diff'; git --no-pager diff --staged; echo '```'; } | wl-copy";
      };
    };
    hooks = {
      post-commit = pkgs.writeShellScript "post-commit" ''
        exec ${config.xdg.configHome}/git/gh-hooks.sh commit
      '';
      pre-push = pkgs.writeShellScript "pre-push" ''
        exec ${config.xdg.configHome}/git/gh-hooks.sh push
      '';
    };
  };
}
