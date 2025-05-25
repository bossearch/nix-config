{
  enable = true;
  setJumps = true;
  gotoNextStart.__raw = ''
    {
      ["]f"] = { query = "@call.outer", desc = "Next function call start" },
      ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
      ["]c"] = { query = "@class.outer", desc = "Next class start" },
      ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
      ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
    }
  '';
  gotoNextEnd.__raw = ''
    {
      ["]F"] = { query = "@call.outer", desc = "Next function call end" },
      ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
      ["]C"] = { query = "@class.outer", desc = "Next class end" },
      ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
      ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    }
  '';
  gotoPreviousStart.__raw = ''
    {
      ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
      ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
      ["[c"] = { query = "@class.outer", desc = "Prev class start" },
      ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
      ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    }
  '';
  gotoPreviousEnd.__raw = ''
    {
      ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
      ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
      ["[C"] = { query = "@class.outer", desc = "Prev class end" },
      ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
      ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    }
  '';
}
