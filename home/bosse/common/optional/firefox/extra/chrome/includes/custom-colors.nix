{...}: {
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-colors.css" = {
    text = ''
      :root {
        --foreground-alpha: #16161ecc;
        --foreground: #16161e;
        --background: #1a1b26;
        --bbackground: #292a34;
        --red: #f7768e;
        --white: #c0caf5;
        --cyan: #27a1b9;
        --favicon-img: url('assets/tab-favicon-f7768e.png');
        &[privatebrowsingmode=temporary] {
          --red: #bb9af7;
          --favicon-img: url('assets/tab-favicon-bb9af7.png');
        }
      }

      /* Change label color of selected tab */
      .tabbrowser-tab[visuallyselected],
      .tabbrowser-tab[multiselected] {
        color: var(--red) !important;
      }

      /* Replace favicon for inactive tab, only for 'tab' label */
      .tabbrowser-tab[label="tab"]:not([visuallyselected]) .tab-icon-image {
        content: url('assets/tab-favicon-c0caf5.png') !important;
      }

      /* Replace favicon for active tab, only for 'tab' label */
      .tabbrowser-tab[label="tab"][visuallyselected] .tab-icon-image {
        content: var(--favicon-img) !important;
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
