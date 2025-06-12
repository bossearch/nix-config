{
  config,
  inputs,
  lib,
  ...
}: let
  nix-colors = inputs.nix-colors;

  floatMod = a: b: a - b * (builtins.floor (a / b));

  rgbToHue = r: g: b: let
    rf = r / 255.0;
    gf = g / 255.0;
    bf = b / 255.0;
    max = lib.max rf (lib.max gf bf);
    min = lib.min rf (lib.min gf bf);
    delta = max - min;

    h' =
      if delta == 0
      then 0
      else if max == rf
      then floatMod ((gf - bf) / delta) 6.0
      else if max == gf
      then ((bf - rf) / delta) + 2.0
      else ((rf - gf) / delta) + 4.0;

    hue = builtins.floor ((60.0 * h') + 0.5);
  in
    if hue < 0
    then hue + 360
    else hue;

  getHueFromHex = hex: let
    rgb = nix-colors.lib.conversions.hexToRGB hex;
    r = builtins.elemAt rgb 0;
    g = builtins.elemAt rgb 1;
    b = builtins.elemAt rgb 2;
  in
    rgbToHue r g b;

  hue-red = toString (getHueFromHex config.colorScheme.palette.base08);
  hue-yellow = toString (getHueFromHex config.colorScheme.palette.base0A);
  hue-green = toString (getHueFromHex config.colorScheme.palette.base0B);
  hue-blue = toString (getHueFromHex config.colorScheme.palette.base0D);
  hue-purple = toString (getHueFromHex config.colorScheme.palette.base0E);

  # Other base colors
  base00 = "#${config.colorScheme.palette.base00}";
  base01 = "#${config.colorScheme.palette.base01}";
  base03 = "#${config.colorScheme.palette.base03}";
  base05 = "#${config.colorScheme.palette.base05}";
  base07 = "#${config.colorScheme.palette.base07}";
in {
  home.file.".config/vesktop/themes/theme.css" = {
    text = ''
      /**
      * @name system24 (tokyo night)
      * @description a tui-like discord theme. based on tokyo night theme (https://github.com/tokyo-night/tokyo-night-vscode-theme).
      * @author refact0r
      * @version 2.0.0
      * @invite nz87hXyvcy
      * @website https://github.com/refact0r/system24
      * @source https://github.com/refact0r/system24/blob/master/theme/system24-tokyo-night.theme.css
      * @authorId 508863359777505290
      * @authorLink https://www.refact0r.dev
      */

      /* import theme modules */
      @import url('https://refact0r.github.io/system24/build/system24.css');

      body {
          /* font, change to ''\'' for default discord font */
          --font: 'DM Mono'; /* change to ''\'' for default discord font */
          --code-font: 'DM Mono'; /* change to ''\'' for default discord font */
          font-weight: 300; /* text font weight. 300 is light, 400 is normal. DOES NOT AFFECT BOLD TEXT */
          letter-spacing: -0.05ch; /* decreases letter spacing for better readability. recommended on monospace fonts.*/

          /* sizes */
          --gap: 12px; /* spacing between panels */
          --divider-thickness: 4px; /* thickness of unread messages divider and highlighted message borders */
          --border-thickness: 2px; /* thickness of borders around main panels. DOES NOT AFFECT OTHER BORDERS */
          --border-hover-transition: 0.2s ease; /* transition for borders when hovered */

          /* animation/transition options */
          --animations: on; /* off: disable animations/transitions, on: enable animations/transitions */
          --list-item-transition: 0.2s ease; /* transition for list items */
          --dms-icon-svg-transition: 0.4s ease; /* transition for the dms icon */

          /* top bar options */
          --top-bar-height: var(--gap); /* height of the top bar (discord default is 36px, old discord style is 24px, var(--gap) recommended if button position is set to titlebar) */
          --top-bar-button-position: titlebar; /* off: default position, hide: hide buttons completely, serverlist: move inbox button to server list, titlebar: move inbox button to channel titlebar (will hide title) */
          --top-bar-title-position: off; /* off: default centered position, hide: hide title completely, left: left align title (like old discord) */
          --subtle-top-bar-title: off; /* off: default, on: hide the icon and use subtle text color (like old discord) */

          /* window controls */
          --custom-window-controls: off; /* off: default window controls, on: custom window controls */
          --window-control-size: 14px; /* size of custom window controls */

          /* dms button options */
          --custom-dms-icon: off; /* off: use default discord icon, hide: remove icon entirely, custom: use custom icon */
          --dms-icon-svg-url: url(''\''); /* icon svg url. MUST BE A SVG. */
          --dms-icon-svg-size: 90%; /* size of the svg (css mask-size property) */
          --dms-icon-color-before: var(--icon-secondary); /* normal icon color */
          --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */
          --custom-dms-background: off; /* off to disable, image to use a background image (must set url variable below), color to use a custom color/gradient */
          --dms-background-image-url: url(''\''); /* url of the background image */
          --dms-background-image-size: cover; /* size of the background image (css background-size property) */
          --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2)); /* fixed color/gradient (css background property) */

          /* background image options */
          --background-image: off; /* off: no background image, on: enable background image (must set url variable below) */
          --background-image-url: url(''\''); /* url of the background image */

          /* transparency/blur options */
          /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
          --transparency-tweaks: off; /* off: no changes, on: remove some elements for better transparency */
          --remove-bg-layer: off; /* off: no changes, on: remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
          --panel-blur: off; /* off: no changes, on: blur the background of panels */
          --blur-amount: 12px; /* amount of blur */
          --bg-floating: var(--bg-3); /* set this to a more opaque color if floating panels look too transparent. only applies if panel blur is on  */

          /* other options */
          --small-user-panel: on; /* off: default user panel, on: smaller user panel like in old discord */

          /* unrounding options */
          --unrounding: on; /* off: default, on: remove rounded corners from panels */

          /* styling options */
          --custom-spotify-bar: on; /* off: default, on: custom text-like spotify progress bar */
          --ascii-titles: on; /* off: default, on: use ascii font for titles at the start of a channel */
          --ascii-loader: system24; /* off: default, system24: use system24 ascii loader, cats: use cats loader */

          /* panel labels */
          --panel-labels: on; /* off: default, on: add labels to panels */
          --label-color: var(--text-muted); /* color of labels */
          --label-font-weight: 500; /* font weight of labels */
      }

      /* color options */
      :root {
          --colors: on; /* off: discord default colors, on: midnight custom colors */

          /* text colors */
          --text-0: var(--bg-3); /* text on colored elements */
          --text-1: hsl(${hue-blue}, 73%, 95%); /* other normally white text */
          --text-2: ${base07}; /* headings and important text */
          --text-3: ${base05}; /* normal text */
          --text-4: hsl(${hue-blue}, 21%, 54%); /* icon buttons and channels */
          --text-5: ${base03}; /* muted channels/chats and timestamps */

          /* background and dark colors */
          --bg-1: hsl(${hue-blue}, 22%, 25%); /* dark buttons when clicked */
          --bg-2: hsl(${hue-blue}, 21%, 19%); /* dark buttons */
          --bg-3: ${base01}; /* spacing, secondary elements */
          --bg-4: ${base00}; /* main background color */
          --hover: hsla(${hue-blue}, 22%, 41%, 0.125); /* channels and buttons when hovered */
          --active: hsla(${hue-blue}, 22%, 41%, 0.267); /* channels and buttons when clicked or selected */
          --active-2: hsla(${hue-blue}, 22%, 41%, 0.333); /* extra state for transparent buttons */
          --message-hover: hsla(${hue-blue}, 0%, 0%, 0.1); /* messages when hovered */

          /* accent colors */
          --accent-1: var(--blue-1); /* links and other accent text */
          --accent-2: var(--blue-2); /* small accent elements */
          --accent-3: var(--blue-3); /* accent buttons */
          --accent-4: var(--blue-4); /* accent buttons when hovered */
          --accent-5: var(--blue-5); /* accent buttons when clicked */
          --accent-new: var(--accent-2); /* stuff that's normally red like mute/deafen buttons */
          --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
          --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
          --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
          --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

          /* status indicator colors */
          --online: var(--green-2);
          --dnd: var(--red-2);
          --idle: var(--yellow-2);
          --streaming: var(--purple-2);
          --offline: var(--text-4);

          /* border colors */
          --border-light: var(--hover);
          --border: var(--active);
          --border-hover: var(--accent-2);
          --button-border: hsl(${hue-blue}, 0%, 0%, 0);

          /* base colors */
          --red-1: hsl(${hue-red}, 99%, 78%);
          --red-2: hsl(${hue-red}, 89%, 72%);
          --red-3: hsl(${hue-red}, 79%, 66%);
          --red-4: hsl(${hue-red}, 69%, 60%);
          --red-5: hsl(${hue-red}, 59%, 54%);

          --green-1: hsl(${hue-green}, 56%, 67%);
          --green-2: hsl(${hue-green}, 51%, 61%);
          --green-3: hsl(${hue-green}, 46%, 56%);
          --green-4: hsl(${hue-green}, 41%, 51%);
          --green-5: hsl(${hue-green}, 36%, 46%);

          --blue-1: hsl(${hue-blue}, 99%, 78%);
          --blue-2: hsl(${hue-blue}, 89%, 72%);
          --blue-3: hsl(${hue-blue}, 79%, 66%);
          --blue-4: hsl(${hue-blue}, 69%, 60%);
          --blue-5: hsl(${hue-blue}, 59%, 54%);

          --yellow-1: hsl(${hue-yellow}, 71%, 72%);
          --yellow-2: hsl(${hue-yellow}, 66%, 64%);
          --yellow-3: hsl(${hue-yellow}, 61%, 59%);
          --yellow-4: hsl(${hue-yellow}, 56%, 54%);
          --yellow-5: hsl(${hue-yellow}, 51%, 49%);

          --purple-1: hsl(${hue-purple}, 95%, 85%);
          --purple-2: hsl(${hue-purple}, 85%, 79%);
          --purple-3: hsl(${hue-purple}, 75%, 73%);
          --purple-4: hsl(${hue-purple}, 65%, 67%);
          --purple-5: hsl(${hue-purple}, 55%, 61%);
      }
    '';
  };
}
