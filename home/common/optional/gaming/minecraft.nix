{pkgs, ...}: {
  home.packages = [
    (pkgs.prismlauncher.override {
      jdks = [
        pkgs.jre21_minimal
        pkgs.jre25_minimal
      ];
      additionalLibs = with pkgs;
        [
          wayland
        ]
        ++ (with pkgs.xorg; [
          libXcursor
          libXrandr
          libXi
          libXinerama
          libXfixes
          libXrender
        ]);
    })
  ];
}
