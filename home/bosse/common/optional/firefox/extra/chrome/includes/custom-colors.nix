{config, ...}: {
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-colors.css" = {
    text = ''
      :root {
        --foreground-alpha: #${config.colorScheme.palette.base01}cc;
        --foreground: #${config.colorScheme.palette.base01};
        --background: #${config.colorScheme.palette.base00};
        --bbackground: #${config.colorScheme.palette.base02};
        --red: #${config.colorScheme.palette.base08};
        --white: #${config.colorScheme.palette.base07};
        --cyan: #${config.colorScheme.palette.base0F};
        &[privatebrowsingmode=temporary] {
          --red: #${config.colorScheme.palette.base0E};
        }
      }

      /* Change label color of selected tab */
      .tabbrowser-tab[visuallyselected],
      .tabbrowser-tab[multiselected] {
        color: var(--red) !important;
      }

      :root {
        --lwt-accent-color: var(--foreground)!important;
        --lwt-text-color: var(--white) !important;
        --arrowpanel-background: var(--background) !important;
        --arrowpanel-color: var(--white) !important;
        --arrowpanel-border-color: var(--foreground) !important;
        --toolbar-field-background-color: var(--foreground) !important;
        --toolbar-bgcolor: var(--background) !important;
        --toolbar-color: var(--white) !important;
        --toolbar-field-color: var(--white) !important;
        --toolbar-field-focus-background-color: var(--foreground) !important;
        --toolbar-field-focus-color: var(--white) !important;
        --newtab-background-color: var(--background) !important;
        --lwt-accent-color-inactive: var(--foreground-alpha) !important;
        --tab-selected-bgcolor: var(--background) !important;
        --tab-selected-textcolor: var(--red) !important;
        --lwt-tab-line-color: var(--red) !important;
        --chrome-content-separator-color: var(--foreground) !important;
        --toolbarbutton-icon-fill: var(--white) !important;
        --sidebar-background-color: var(--background) !important;
        --sidebar-text-color: var(--white) !important;
        --tabpanel-background-color: var(--background) !important;
        --tab-loading-fill: var(--red) !important;
        --toolbarbutton-hover-background: var(--bbackground) !important;
        --toolbarbutton-active-background: var(--foreground) !important;
        --toolbar-field-focus-border-color: var(--cyan) !important;
        --lwt-toolbar-field-highlight: var(--cyan) !important;
        --sidebar-border-color: var(--cyan) !important;
      }

      .sidebar-splitter {
          width: 1px !important;
          background-color: var(--cyan) !important;
          border-right-style: none !important;
          border-left-style: none !important;
      }

      #main-window {
        background-color: var(--foreground) !important;
      }
      #main-window:-moz-window-inactive {
        background-color: var(--foreground-alpha) !important;
      }
    '';
  };
}
