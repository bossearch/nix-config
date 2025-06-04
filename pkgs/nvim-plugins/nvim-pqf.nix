{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "nvim-pqf";
  version = "04-06-2025";
  dontBuilt = true;
  src = fetchFromGitHub {
    owner = "yorickpeterse";
    repo = "nvim-pqf";
    rev = "148ee2ca8b06d83fd9bf6f9b9497724ad39a07d6";
    sha256 = "sha256-5VH1ffXvQuMDm32xt2t2UlEJiKuZWbkAMTXJic/8BYI=";
  };
  meta.homepage = "https://github.com/yorickpeterse/nvim-pqf";
  meta.description = "Prettier quickfix/location list windows for NeoVim";
}
