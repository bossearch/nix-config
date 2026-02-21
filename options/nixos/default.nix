{
  mylib,
  outputs,
  ...
}: {
  imports =
    (mylib.autoimport ./core)
    ++ (mylib.autoimport ./optional)
    ++ (builtins.attrValues outputs.nixosModules);
}
