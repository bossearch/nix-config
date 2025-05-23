{...}:{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        run = "plugin ouch --args=zip";
        on = ["C"];
        desc = "Compress with ouch";
      }
      {
        run = "plugin smart-enter";
        on = ["l"];
        desc = "Enter the child directory, or open the file";
      }
      {
        run = "plugin smart-paste";
        on = ["p"];
        desc = "Paste into the hovered directory or CWD";
      }
      {
        run = "plugin chmod";
        on = ["c" "m"];
        desc = "Chmod on selected files";
      }
    ];
  };
}
