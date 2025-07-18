{pkgs, ...}: {
  home.file.".config/qt5ct/qt5ct.conf" = {
    text = ''
      [Appearance]
      color_scheme_path=${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/airy.conf
      custom_palette=false
      icon_theme=Papirus-Dark
      standard_dialogs=default
      style=kvantum-dark

      [Fonts]
      fixed="Noto Sans,12,-1,5,50,0,0,0,0,0"
      general="Noto Sans,12,-1,5,50,0,0,0,0,0"

      [Interface]
      activate_item_on_single_click=1
      buttonbox_layout=0
      cursor_flash_time=1000
      dialog_buttons_have_icons=1
      double_click_interval=400
      gui_effects=@Invalid()
      keyboard_scheme=2
      menus_have_icons=true
      show_shortcuts_in_context_menus=true
      stylesheets=@Invalid()
      toolbutton_style=4
      underline_shortcut=1
      wheel_scroll_lines=3

      [SettingsWindow]
      geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x4\xef\0\0\x5j\0\0\0\0\0\0\0\0\0\0\x2\xde\0\0\x3\x65\0\0\0\0\x2\0\0\0\n\0\0\0\0\0\0\0\0\0\0\0\x4\xef\0\0\x5j)

      [Troubleshooting]
      force_raster_widgets=1
      ignored_applications=@Invalid()
    '';
  };
}
