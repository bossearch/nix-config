{...}: {
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-urlbar.css" = {
    text = ''
      /* work but you need to hover on correct place which is on urlbar box area */
      :root {
        --uc-toolbox-height: 43px;
        --uc-browser-height: -26px;
      }
      :root[uidensity="compact"]{
        --uc-toolbox-height: 38px;
        --uc-browser-height: -23px;
      }

      #urlbar{
        margin-top: -100px;
      }

      #navigator-toolbox {
        transition: margin-top 0.2s ease-in-out, opacity 0.2s ease-in-out;
        margin-top: calc(-1 * var(--uc-toolbox-height));
        opacity: 0;
      }

      /* Prevent only navigator-toolbox hidden when moving tabs sadly not work on multiple windows */
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) {
        margin-top: 0 !important;
        transition: margin-top 0.2s ease-in-out, opacity 0.2s ease-in-out;
        opacity: 1 !important;
      }
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #nav-bar,
      #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #urlbar {
        opacity: 0 !important;
      }

      /* Prevent toolbox from showing when opening a new tab */
      /*#navigator-toolbox:has(#urlbar:focus-within) {*/
      /*  margin-top: calc(-1 * var(--uc-toolbox-height)) !important;*/
      /*  opacity: 0 !important;*/
      /*}*/

      /* Show toolbox when hovered or focused */
      #navigator-toolbox:hover,
      #navigator-toolbox:focus-within {
        margin-top: 0 !important;
        opacity: 1 !important;
      }

      /* show url bar when hovering or focus on navigator-toolbox and nav-bar*/
      #navigator-toolbox:hover #urlbar,
      #navigator-toolbox:focus-within #urlbar,
      #nav-bar:hover #urlbar,
      #nav-bar:focus-within #urlbar {
        margin-top: 0 !important;
        transition: margin-top 0.1s ease-in-out;
      }

      /* Shift the web content up when the toolbox is hidden */
      #browser {
        transition: margin-top 0.2s ease-in-out;
        margin-top: var(--uc-browser-height);
        margin-bottom: 8px;
        margin-left: 8px;
        margin-right: 8px;
        border-radius: 8px;
        overflow: hidden;
      }

      #navigator-toolbox:hover ~ #browser,
      #navigator-toolbox:focus-within ~ #browser,
      #nav-bar:hover #urlbar ~ #browser,
      #nav-bar:focus-within #urlbar ~ #browser {
        margin-top: 0 !important;
      }

      /* Ensure everything is visible while customizing */
      :root[customizing] #navigator-toolbox,
      :root[customizing] #urlbar {
        margin-top: 0 !important;
        opacity: 1 !important;
      }
    '';
  };
}
