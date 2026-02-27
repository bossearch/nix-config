{
  homes,
  hosts,
  lib,
  ...
}: let
  css =
    if homes.firefox.verticaltab.enable
    then {
      browser =
        if homes.firefox.verticaltab.position == "left"
        then {
          left = "0px";
          right = "8px";
          top = "-29px";
        }
        else {
          left = "8px";
          right = "0px";
          top = "-29px";
        };
      navigator-toolbox = ''
        margin-top: -9px;
        padding: 6px;
      '';
      vertical-spacer = ''
        #vertical-spacer {
          display: none !important;
        }
      '';
    }
    else {
      browser = {
        left = "8px";
        right = "8px";
        top = "-67px";
      };
      navigator-toolbox = "margin-top: calc(-1 * var(--uc-toolbox-height));";
      vertical-spacer = "";
    };
in {
  home.file.".mozilla/firefox/${hosts.username}/chrome/extras/custom-urlbar.css" = lib.mkIf homes.firefox.enable {
    text = ''
      /* Remove margins when #browser is in fullscreen */
      :root[inFullscreen] #browser {
        margin-top: 0px !important;
        margin-bottom: 0px !important;
        margin-left: 0px !important;
        margin-right: 0px !important;
        border-radius: 0px !important;
      }

      /* Ensure everything is visible while customizing */
      :root[customizing] #navigator-toolbox,
      :root[customizing] #urlbar {
        margin-top: 0px !important;
        opacity: 1 !important;
      }

      /* work but you need to hover on correct place which is on urlbar box area */
      #urlbar{
        opacity: 0;
      }

      #navigator-toolbox {
        transition: margin-top 0.2s ease-in-out, opacity 0.2s ease-in-out !important;
        ${css.navigator-toolbox}
        opacity: 0;
      }

      /* Prevent toolbox from showing when opening a new tab */
      /*#navigator-toolbox:has(#urlbar:focus-within) {*/
      /*  margin-top: calc(-1 * var(--uc-toolbox-height)) !important;*/
      /*  opacity: 0 !important;*/
      /*}*/

      /* Show toolbox when hovered or focused */
      #navigator-toolbox:hover,
      #navigator-toolbox:focus-within {
        margin-top: 0px !important;
        opacity: 1 !important;
      }

      /* show url bar when hovering or focus on navigator-toolbox and nav-bar*/
      #navigator-toolbox:hover #urlbar,
      #navigator-toolbox:focus-within #urlbar,
      #nav-bar:hover #urlbar,
      #nav-bar:focus-within #urlbar {
        opacity: 1 !important;
        transition: opacity 0.1s ease-in-out !important;
      }

      /* Shift the web content up when the toolbox is hidden */
      #browser {
        transition: margin-top 0.2s ease-in-out !important;
        margin-bottom: 8px;
        margin-left: ${css.browser.left};
        margin-right: ${css.browser.right};
        margin-top: ${css.browser.top};
        border-radius: 8px;
        overflow: hidden;
      }

      #navigator-toolbox:hover ~ #browser,
      #navigator-toolbox:focus-within ~ #browser,
      #nav-bar:hover #urlbar ~ #browser,
      #nav-bar:focus-within #urlbar ~ #browser {
        margin-top: 0px !important;
      }

      /* Prevent only navigator-toolbox hidden when moving tabs sadly not work on multiple windows */
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) {
        margin-top: 0px !important;
        transition: margin-top 0.2s ease-in-out, opacity 0.2s ease-in-out;
        opacity: 1 !important;
      }
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #nav-bar,
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #urlbar {
        opacity: 0 !important;
      }

      ${css.vertical-spacer}
    '';
  };
}
