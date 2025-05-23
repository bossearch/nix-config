{...}: {
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-tabbar.css" = {
    text = ''
      :root {
        /* Show X button on tab bar option */
        --show-tab-close-button: none;
        --show-tab-close-button-hover: -moz-inline-block;

        /* Container tabs indicator */
        --container-tabs-indicator-margin: 10px; /*higher is smaller*/

        /*  Amount of Glow to add to the container indicator, Setting it to 0 disables the Glow */
        --uc-identity-glow: 0 1px 10px 1px;
      }

      /* Show X button on tab bar */
      .tabbrowser-tab:not([pinned]) .tab-close-button { display: var(--show-tab-close-button) !important; }
      .tabbrowser-tab:not([pinned]):hover .tab-close-button { display: var(--show-tab-close-button-hover) !important }

      /* Container tabs indicator */
      .tabbrowser-tab[usercontextid]
        > .tab-stack
        > .tab-background
        > .tab-context-line {
          margin: -1px var(--container-tabs-indicator-margin) 0 var(--container-tabs-indicator-margin) !important;
          height: 1px !important;
          box-shadow: var(--uc-identity-glow) var(--identity-tab-color) !important;
      }

      /* Remove gap after pinned tabs */
      #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
        > #tabbrowser-arrowscrollbox
        > .tabbrowser-tab:nth-child(1 of :not([pinned], [hidden])) { margin-inline-start: 0 !important; }

      /* Remove outline and box-shadow on tab backgrounds */
      .tabbrowser-tab .tab-background {
        outline: none !important;
        /* box-shadow: none !important;
        */
      }

      /* multi tab selection */
      #tabbrowser-tabs:not([noshadowfortests]) .tabbrowser-tab:is([multiselected])
        > .tab-stack
        > .tab-background:-moz-lwtheme { outline-color: var(--toolbarseparator-color) !important; }
    '';
  };
}
