{
  xdg.desktopEntries.nvim = {
    type = "Application";
    name = "Neovim";
    genericName = "Text Editor";
    icon = "nvim";
    exec = "kitty -T nvim nvim";
    comment = "Edit text files";
    categories = ["Utility" "TextEditor"];
    mimeType = [
      "text/english"
      "text/plain"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
    ];
  };
}
