{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "colorful-winsep";
  version = "11-04-2025";
  dontBuilt = true;
  src = fetchFromGitHub {
    owner = "nvim-zh";
    repo = "colorful-winsep.nvim";
    rev = "7bbe4e1353c0fe37c98bad2758aafc410280f6b3";
    sha256 = "sha256-3ZXbpUNZqLHaUWgb2wHnfQfcGkMpcRtAt8q7z0tmo1o=";
  };
  meta.homepage = "https://github.com/nvim-zh/colorful-winsep.nvim";
  meta.description = "Make your nvim window separators colorful";
}
