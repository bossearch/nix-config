{
  homes,
  inputs,
  ...
}: {
  imports = [inputs.copas.homeManagerModules.default];
  programs.copas = {
    enable = homes.copas;
    systemd = true;

    settings = {
      port = 6669;
      auth_token = "l)8/NM{V,(OSx!N,Z2XDujKIs_%#fIPJQ0gRZAj_*c3Iv,aJ%7K+8j1Xevy8biLv";
    };
  };
}
