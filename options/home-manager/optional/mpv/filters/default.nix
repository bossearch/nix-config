{
  homes,
  lib,
  pkgs,
  ...
}: {
  home.file.".config/mpv/filters/mvtools.vpy" = lib.mkIf homes.mpv {
    text = ''
      import vapoursynth as vs
      core = vs.core
      core.std.LoadPlugin("${pkgs.vapoursynth-mvtools}/lib/vapoursynth/libmvtools.so")

      clip = video_in
      dst_fps = display_fps
      while (dst_fps > 60):
          dst_fps = 60

      src_fps_num = int(container_fps * 1e8)
      src_fps_den = int(1e8)
      dst_fps_num = int(dst_fps * 1e4)
      dst_fps_den = int(1e4)

      clip = core.std.AssumeFPS(clip, fpsnum=src_fps_num, fpsden=src_fps_den)
      super = core.mv.Super(clip, pel=2, sharp=0, rfilter=2)
      mvfw = core.mv.Analyse(super, blksize=32, isb=False, search=3, dct=5)
      mvbw = core.mv.Analyse(super, blksize=32, isb=True,  search=3, dct=5)
      clip = core.mv.FlowFPS(clip, super, mvbw, mvfw, num=dst_fps_num, den=dst_fps_den, mask=1)
      clip.set_output()
    '';
  };
}
