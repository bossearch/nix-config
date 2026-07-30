{
  homes,
  hosts,
  mylib,
  ...
}: let
  enabled = hosts.gui.enable && homes.qtstyle == "kvantum";
in {
  imports = mylib.autoimport ./.;

  qt.kvantum = {
    enable = enabled;
    settings.General.theme = "KvMyColors";
  };
}
