# TODO: test select for remain keymaps
{
  enable = true;
  lookahead = true;
  keymaps.__raw = ''
    {
      -- You can use the capture groups defined in textobjects.scm
      ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
      ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
      ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
      ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
    }
  '';
}
