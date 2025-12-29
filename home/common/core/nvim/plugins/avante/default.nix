{
  programs.nixvim.plugins.avante = {
    enable = true;
    settings = {
      mode = "legacy";
      provider = "ollama";
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434";
          model = "This-Clown-Gonna-Make-My-GPU-Screaming:v1";
          timeout = 30000;
          # disable_tools = true;
          is_env_set.__raw = ''
            require("avante.providers.ollama").check_endpoint_alive
          '';
        };
      };
      input = {
        provider = "snacks";
        provider_opts = {
          title = "Avante Input";
          icon = " ";
        };
      };
      prompt_logger = {
        enabled = false;
        log_dir.__raw = ''
          vim.fn.stdpath("cache") .. "/avante_prompts"
        '';
      };
      windows = {
        position = "right";
        wrap = true;
        width = 30;
        sidebar_header = {
          enabled = false;
        };
        input = {
          prefix = "❯ ";
          height = 8;
        };
      };
    };
  };
}
