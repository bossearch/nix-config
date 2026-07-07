{config, ...}: let
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base02 = "#${config.colorScheme.palette.base02}";
  base03 = "#${config.colorScheme.palette.base03}";
  base04 = "#${config.colorScheme.palette.base04}";
  base05 = "#${config.colorScheme.palette.base05}";
  base06 = "#${config.colorScheme.palette.base06}";
  base07 = "#${config.colorScheme.palette.base07}";
  base08 = "#${config.colorScheme.palette.base08}";
  base09 = "#${config.colorScheme.palette.base09}";
  base0A = "#${config.colorScheme.palette.base0A}";
  base0B = "#${config.colorScheme.palette.base0B}";
  base0C = "#${config.colorScheme.palette.base0C}";
  base0D = "#${config.colorScheme.palette.base0D}";
  base0E = "#${config.colorScheme.palette.base0E}";
  base0F = "#${config.colorScheme.palette.base0F}";
in {
  theme = {
    accent = {
      dark = "${base0F}";
      light = "${base07}";
    };
    background = {
      dark = "${base01}";
      light = "${base06}";
    };
    backgroundElement = {
      dark = "${base00}";
      light = "${base04}";
    };
    backgroundPanel = {
      dark = "${base00}";
      light = "${base05}";
    };
    border = {
      dark = "${base02}";
      light = "${base03}";
    };
    borderActive = {
      dark = "${base03}";
      light = "${base02}";
    };
    borderSubtle = {
      dark = "${base02}";
      light = "${base03}";
    };
    diffAdded = {
      dark = "${base0B}";
      light = "${base0B}";
    };
    diffAddedBg = {
      dark = "${base01}";
      light = "${base05}";
    };
    diffAddedLineNumberBg = {
      dark = "${base01}";
      light = "${base05}";
    };
    diffContext = {
      dark = "${base03}";
      light = "${base03}";
    };
    diffContextBg = {
      dark = "${base01}";
      light = "${base05}";
    };
    diffHighlightAdded = {
      dark = "${base0B}";
      light = "${base0B}";
    };
    diffHighlightRemoved = {
      dark = "${base08}";
      light = "${base08}";
    };
    diffHunkHeader = {
      dark = "${base03}";
      light = "${base03}";
    };
    diffLineNumber = {
      dark = "${base03}";
      light = "${base04}";
    };
    diffRemoved = {
      dark = "${base08}";
      light = "${base08}";
    };
    diffRemovedBg = {
      dark = "${base01}";
      light = "${base05}";
    };
    diffRemovedLineNumberBg = {
      dark = "${base01}";
      light = "${base05}";
    };
    error = {
      dark = "${base08}";
      light = "${base08}";
    };
    info = {
      dark = "${base0C}";
      light = "${base0F}";
    };
    markdownBlockQuote = {
      dark = "${base03}";
      light = "${base01}";
    };
    markdownCode = {
      dark = "${base0B}";
      light = "${base0B}";
    };
    markdownCodeBlock = {
      dark = "${base01}";
      light = "${base00}";
    };
    markdownEmph = {
      dark = "${base0A}";
      light = "${base09}";
    };
    markdownHeading = {
      dark = "${base0E}";
      light = "${base0F}";
    };
    markdownHorizontalRule = {
      dark = "${base04}";
      light = "${base03}";
    };
    markdownImage = {
      dark = "${base0D}";
      light = "${base0D}";
    };
    markdownImageText = {
      dark = "${base0C}";
      light = "${base07}";
    };
    markdownLink = {
      dark = "${base0D}";
      light = "${base0D}";
    };
    markdownLinkText = {
      dark = "${base0C}";
      light = "${base07}";
    };
    markdownListEnumeration = {
      dark = "${base0C}";
      light = "${base07}";
    };
    markdownListItem = {
      dark = "${base0D}";
      light = "${base0F}";
    };
    markdownStrong = {
      dark = "${base09}";
      light = "${base0A}";
    };
    markdownText = {
      dark = "${base05}";
      light = "${base00}";
    };
    primary = {
      dark = "${base0D}";
      light = "${base0F}";
    };
    secondary = {
      dark = "${base0E}";
      light = "${base0D}";
    };
    success = {
      dark = "${base0B}";
      light = "${base0B}";
    };
    syntaxComment = {
      dark = "${base04}";
      light = "${base03}";
    };
    syntaxFunction = {
      dark = "${base0D}";
      light = "${base0C}";
    };
    syntaxKeyword = {
      dark = "${base0E}";

      light = "${base0D}";
    };
    syntaxNumber = {
      dark = "${base09}";
      light = "${base0E}";
    };
    syntaxOperator = {
      dark = "${base0C}";
      light = "${base0D}";
    };
    syntaxPunctuation = {
      dark = "${base05}";
      light = "${base00}";
    };
    syntaxString = {
      dark = "${base0B}";
      light = "${base0B}";
    };
    syntaxType = {
      dark = "${base0A}";
      light = "${base07}";
    };
    syntaxVariable = {
      dark = "${base07}";
      light = "${base07}";
    };
    text = {
      dark = "${base05}";
      light = "${base00}";
    };
    textMuted = {
      dark = "${base04}";
      light = "${base01}";
    };
    warning = {
      dark = "${base0A}";
      light = "${base0A}";
    };
  };
}
