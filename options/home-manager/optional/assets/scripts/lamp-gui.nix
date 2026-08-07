{
  hosts,
  lib,
  pkgs,
  ...
}: let
  lampGui = pkgs.stdenv.mkDerivation {
    name = "lamp-gui";
    nativeBuildInputs = [
      pkgs.wrapGAppsHook3
      pkgs.gobject-introspection
    ];
    buildInputs = [
      pkgs.gtk3
      (pkgs.python3.withPackages (ps: [ps.pygobject3]))
    ];
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cat << 'EOF' > $out/bin/lamp-gui
      #!/usr/bin/env python3

      import os
      import subprocess
      import sys

      HOME = os.path.expanduser("~")
      USER = os.environ.get("USER", os.path.basename(HOME))
      extra_paths = [
          os.path.join(HOME, ".nix-profile/bin"),
          f"/etc/profiles/per-user/{USER}/bin",
          "/run/current-system/sw/bin",
          "/usr/local/bin",
          "/usr/bin",
          "/bin",
      ]
      os.environ["PATH"] = ":".join(extra_paths) + ":" + os.environ.get("PATH", "")

      import gi

      gi.require_version("Gdk", "3.0")
      gi.require_version("Gtk", "3.0")
      from gi.repository import Gdk, Gtk

      SET_SCRIPT = os.path.join(
          HOME, ".config/waybar/scripts/utility/lamp-control/set-lamp.sh"
      )
      GET_SCRIPT = os.path.join(
          HOME, ".config/waybar/scripts/utility/lamp-control/get-lamp.sh"
      )


      class LampControl(Gtk.Window):
          def __init__(self):
              super().__init__(title="Lamp Control")
              self.set_border_width(15)
              val = None
              try:
                  out = subprocess.check_output(["bash", GET_SCRIPT]).decode().strip()
                  if out.isdigit():
                      val = int(out)
              except Exception:
                  val = None

              vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
              self.add(vbox)

              label = Gtk.Label(label="Lamp Control")
              vbox.pack_start(label, False, False, 0)

              if val is None:
                  status_label = Gtk.Label(label="Lamp is disconnected")
                  vbox.pack_start(status_label, True, True, 0)
              elif val == 0:
                  status_label = Gtk.Label(
                      label="Lamp is off, press state to turn on the lamp"
                  )
                  vbox.pack_start(status_label, True, True, 0)
              else:
                  val = max(10, min(100, round(val / 10.0) * 10))
                  self.last_val = val

                  self.adjustment = Gtk.Adjustment(
                      value=val,
                      lower=10,
                      upper=100,
                      step_increment=10,
                      page_increment=10,
                  )
                  self.scale = Gtk.Scale(
                      orientation=Gtk.Orientation.HORIZONTAL, adjustment=self.adjustment
                  )
                  self.scale.set_digits(0)
                  self.scale.set_value_pos(Gtk.PositionType.TOP)

                  self.scale.connect("scroll-event", self.on_scroll)
                  self.scale.connect("value-changed", self.on_value_changed)
                  vbox.pack_start(self.scale, True, True, 0)

              btn_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
              vbox.pack_start(btn_box, False, False, 0)

              buttons = [
                  ("Cozy", "cozy"),
                  ("Temp", "temp"),
                  ("State", "state"),
                  ("Close", "close"),
              ]
              for label_text, action in buttons:
                  btn = Gtk.Button(label=label_text)
                  if val is None and action != "close":
                      btn.set_sensitive(False)
                  btn.connect("clicked", self.on_button_clicked, action)
                  btn_box.pack_start(btn, True, True, 0)

          def on_scroll(self, widget, event):
              current = self.scale.get_value()

              if event.direction == Gdk.ScrollDirection.UP:
                  new_val = min(100, current + 10)
              elif event.direction == Gdk.ScrollDirection.DOWN:
                  new_val = max(10, current - 10)
              elif event.direction == Gdk.ScrollDirection.SMOOTH:
                  _, _, delta_y = event.get_scroll_deltas()
                  new_val = current - 10 if delta_y > 0 else current + 10
                  new_val = max(10, min(100, new_val))
              else:
                  return False

              self.scale.set_value(new_val)
              return True

          def on_value_changed(self, widget):
              val = int(round(self.scale.get_value() / 10.0) * 10)
              val = max(10, min(100, val))

              if val != self.last_val:
                  self.last_val = val
                  subprocess.Popen(["bash", SET_SCRIPT, str(val)])

          def on_button_clicked(self, widget, action):
              if action != "close":
                  subprocess.run(["bash", SET_SCRIPT, action], check=False)
              Gtk.main_quit()


      if __name__ == "__main__":
          win = LampControl()
          win.connect("destroy", Gtk.main_quit)
          win.show_all()
          Gtk.main()
      EOF
      chmod +x $out/bin/lamp-gui
    '';
  };
in {
  home = lib.mkIf hosts.gui.enable {
    file.".config/assets/scripts/lamp-control/lamp-gui.py".source = "${lampGui}/bin/lamp-gui";
  };
}
