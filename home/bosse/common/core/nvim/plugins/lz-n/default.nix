{
  programs.nixvim.plugins.lz-n = {
    enable = true;
    autoLoad = true;
    plugins = [
      {
        __unkeyed-1 = "markdown-preview";
        ft = "markdown";
      }
      {
        __unkeyed-1 = "treesitter-textobjects";
        event = ["BufReadPre" "BufNewFile"];
      }
    ];
  };
}
