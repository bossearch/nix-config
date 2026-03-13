{
  lib,
  rustPlatform,
  fetchFromGitLab,
  installShellFiles,
  tree,
  git,
  wl-clipboard ? null,
}: let
  fishCompletion = import ./fish-completion.nix {
    builtins = builtins;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "seniorpw";
    version = "0.8.4";

    src = fetchFromGitLab {
      owner = "retirement-home";
      repo = pname;
      rev = version;
      hash = "sha256-ygRUx8XN1+dpPca3ZSeV+PCxOvdzAx0CqKdGeR0cFN0=";
    };

    sourceRoot = "source/src/seniorpw";

    cargoHash = "sha256-xslnYaxSdo+2xoddPsFHPrIr1cvOdSLzgZH7t3kKA0Y=";

    nativeBuildInputs = [
      git
      installShellFiles
    ];

    buildInputs = [tree] ++ lib.optional (wl-clipboard != null) wl-clipboard;

    postPatch = ''
      echo "fn main() {}" > build.rs
    '';

    postInstall = ''
      install -Dm755 ../seniormenu -t $out/bin
      installManPage ../man/*

      installShellCompletion --bash ../completions/senior.bash
      installShellCompletion --zsh ../completions/senior.zsh
      installShellCompletion --fish ${fishCompletion}

      install -Dm644 ../../LICENSE -t $out/share/licenses/${pname}
    '';

    meta = with lib; {
      description = "Password manager using age as backend";
      homepage = "https://gitlab.com/retirement-home/seniorpw";
      license = licenses.agpl3Only;
      platforms = platforms.unix;
      mainProgram = "senior";
    };
  }
