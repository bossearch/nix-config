{
  programs.nixvim.plugins.undotree = {
    enable = true;
    settings = {
      CursorLine = true;
      DiffAutoOpen = false;
      DiffCommand = "diff";
      DiffpanelHeight = 10;
      HelpLine = true;
      HighlightChangedText = false;
      HighlightChangedWithSign = true;
      HighlightSyntaxAdd = "DiffAdd";
      HighlightSyntaxChange = "DiffChange";
      HighlightSyntaxDel = "DiffDelete";
      RelativeTimestamp = true;
      SetFocusWhenToggle = true;
      ShortIndicators = false;
      SplitWidth = 36;
      TreeNodeShape = "*";
      TreeReturnShape = "\\";
      TreeSplitShape = "/";
      TreeVertShape = "|";
      WindowLayout = 4;
      DisabledBuftypes = ["terminal" "prompt" "quickfix" "nofile" "acwrite"];
    };
  };
}
