{
  programs.nixvim = {
    keymaps = [
      {
        key = ";";
        action.__raw = ''
          function()
            require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move()
          end
        '';
        mode = ["n" "x" "o"];
      }
      {
        key = ",";
        action.__raw = ''
          function()
            require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_opposite()
          end
        '';
        mode = ["n" "x" "o"];
      }
    ];
  };
}
