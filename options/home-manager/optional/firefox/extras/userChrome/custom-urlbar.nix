{homes, ...}: let
  css =
    if homes.firefox.verticaltab.enable
    then {
      browser =
        if homes.firefox.verticaltab.position == "left"
        then {
          left = "0px";
          right = "8px";
          top = "-38px";
        }
        else {
          left = "8px";
          right = "0px";
          top = "-38px";
        };
      navigator-toolbox = ''
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
      navigator-toolbox = "";
      vertical-spacer = "";
    };
in ''
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

  /* Hide navigator-toolbox */
  #navigator-toolbox {
    opacity: 0;
    ${css.navigator-toolbox}
  }

  /* Show navigator-toolbox */
  #navigator-toolbox:is(:hover, :focus-within, :has([open]), :has(#toolbar-menubar:not([inactive]))) {
    opacity: 1 !important;
  }

  /* Hide urlbar */
  #urlbar{
    opacity: 0;
    pointer-events: none;
  }

  /* Show urlbar */
  #navigator-toolbox:is(:hover, :focus-within, :has([open]), :has(#toolbar-menubar:not([inactive]))) #urlbar {
    opacity: 1 !important;
    pointer-events: auto !important;
    transition: opacity 0.2s cubic-bezier(1, 0, 1, 0) !important;
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

  #navigator-toolbox:is(:hover, :focus-within, :has([open]), :has(#toolbar-menubar:not([inactive]))) ~ #browser,
  #navigator-toolbox:is(:hover, :focus-within, :has([open]), :has(#toolbar-menubar:not([inactive]))) #urlbar ~ #browser {
    margin-top: 0px !important;
    transition: margin-top 0.2s ease-in-out !important;
  }

  /* Prevent tab-bar hidden when moving tabs sadly not work on multiple windows */
  #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) {
    opacity: 1 !important;
  }
  #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #nav-bar {
    margin-top: 32px !important;
  }
  #navigator-toolbox:not(:hover):not(:focus-within):has(#tabbrowser-tabs[movingtab]) #urlbar {
    opacity: 0 !important;
  }
  ${css.vertical-spacer}
''
