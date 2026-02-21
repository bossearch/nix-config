{
  inputs,
  mylib,
  ...
}: {
  imports =
    [
      inputs.disko.nixosModules.disko
    ]
    ++ (mylib.autoimport ./.);
}
