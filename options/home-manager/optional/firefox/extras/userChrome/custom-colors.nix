{
  config,
  homes,
  ...
}: let
  conditional =
    if homes.firefox.verticaltab.enable
    then ''
      --toolbar-field-background-color: var(--background) !important;
      --toolbar-field-background-color-focus: var(--background) !important;
    ''
    else ''
      --toolbar-field-background-color: var(--foreground) !important;
      --toolbar-field-background-color-focus: var(--foreground) !important;
    '';
in ''
  :root {
    --foreground-alpha: #${config.colorScheme.palette.base00}cc;
    --foreground: #${config.colorScheme.palette.base00};
    --background: #${config.colorScheme.palette.base01};
    --bbackground: #${config.colorScheme.palette.base02};
    --red: #${config.colorScheme.palette.base08};
    --white: #${config.colorScheme.palette.base07};
    --cyan: #${config.colorScheme.palette.base0F};
    &[privatebrowsingmode="temporary"] {
      --red: #${config.colorScheme.palette.base0E};
    }
  }

  /* Change label color of selected tab */
  .tabbrowser-tab[visuallyselected],
  .tabbrowser-tab[multiselected] {
    color: var(--red) !important;
  }

  /* ==============
     Firefox window
     ============== */
  :root {
    /* sidebar */
    --sidebar-background-color: var(--background) !important;
    --sidebar-border-color: var(--foreground) !important;
    --sidebar-text-color: var(--white) !important;

    /* current active tab */
    --tab-loading-fill: var(--red) !important;
    --tab-background-color-selected: var(--background) !important;
    --tab-background-color-hover: var(--bbackground) !important;
    --tab-selected-textcolor: var(--red) !important;

    /* toolbar */
    --toolbar-background-color: var(--background) !important;
    --toolbar-color: var(--white) !important;

    /* tab list color */
    --toolbox-text-color: var(--white) !important;
    --toolbox-background-color-inactive: var(--foreground-alpha) !important;
    --toolbox-background-color: var(--foreground) !important;

    /* toolbar button when hovered or active */
    --toolbarbutton-background-color-active: var(--foreground) !important;
    --toolbarbutton-background-color-hover: var(--bbackground) !important;
    --toolbarbutton-icon-fill: var(--white) !important;

    /* urlbar box */
    ${conditional}
    --toolbar-field-text-color: var(--white) !important;
    --toolbar-field-text-color-focus: var(--white) !important;
    --focus-outline-color: var(--cyan) !important;

    /* urlbar box like ddg icon */
    --urlbar-box-background-color: var(--bbackground) !important;
    --urlbar-box-background-color-focus: var(--bbackground) !important;

    /* urlbar dropdown*/
    --urlbarview-background-color-hover: var(--bbackground) !important;
    --urlbarview-background-color-selected: var(--bbackground) !important;
    --urlbarview-separator-color: var(--cyan) !important;
    --urlbarview-text-color-selected: var(--white) !important;
    --link-color: var(--cyan) !important;

    /* panel */
    --panel-border-color: var(--foreground) !important;
    --panel-background-color: var(--foreground) !important;
    --panel-color: var(--white) !important;
  }

  #main-window {
    background-color: var(--foreground) !important;
  }

  #main-window:-moz-window-inactive {
    background-color: var(--foreground-alpha) !important;
  }

  .menupopup-arrowscrollbox {
    background: var(--background) !important;
  }

  menuseparator,
  panel toolbarseparator {
    color: var(--white) !important;
  }

  /* ==============================
     urlbar star button popup panel
     ============================== */

  #editBookmarkHeaderSeparator,
  #editBookmarkPanel .panel-header,
  #editBookmarkPanel .panel-subview-body {
    background-color: var(--background) !important;
    color: var(--white) !important;
  }

  #editBookmarkHeaderSeparator {
    margin-inline: 0px !important;
  }

  #editBookmarkPanel label {
    color: var(--white) !important;
  }

  #editBookmarkPanel input,
  #editBookmarkPanel button,
  #editBMPanel_folderTree,
  #editBMPanel_folderMenuList,
  #editBMPanel_tagsSelector {
    appearance: none !important;
    -moz-appearance: none !important;
    background-color: var(--foreground) !important;
    color: var(--white) !important;
    border: 1px solid var(--bbackground) !important;
    border-radius: 6px !important;
  }

  #editBookmarkPanel input:focus {
    border-color: var(--cyan) !important;
    outline: none !important;
  }

  #editBookmarkPanel button * {
    color: inherit !important;
  }

  #editBMPanel_folderMenuList:hover,
  #editBookmarkPanel button:hover {
    background-color: var(--bbackground) !important;
    color: var(--white) !important;
  }

  #editBookmarkPanel #editBookmarkPanelRemoveButton:hover {
    background-color: var(--red) !important;
    border-color: var(--red) !important;
    color: var(--foreground) !important;
  }

  #editBookmarkPanel #editBookmarkPanelDoneButton:hover {
    background-color: var(--cyan) !important;
    border-color: var(--cyan) !important;
    color: var(--foreground) !important;
  }

  #editBMPanel_folderTree treechildren::-moz-tree-row(hover),
  #editBMPanel_folderTree treechildren::-moz-tree-row(selected) {
    background-color: var(--bbackground) !important;
  }
  #editBMPanel_folderTree treechildren::-moz-tree-cell-text(selected) {
    color: var(--white) !important;
  }

  #editBMPanel_folderTree treechildren::-moz-tree-image,
  #editBMPanel_folderTree treechildren::-moz-tree-image(selected),
  #editBMPanel_folderTree treechildren::-moz-tree-twisty {
    fill: var(--white) !important;
  }

  #editBMPanel_folderTree treechildren::-moz-tree-row(selected) {
    outline: none !important;
  }

  /* ==============
     Library window
     ============== */
  @-moz-document url("chrome://browser/content/places/places.xhtml")
  {
    #detailsPane,
    tree {
      background-color: var(--background) !important;
      color: var(--white) !important;
    }

    toolbar {
      background-color: var(--foreground) !important;
    }

    #placesToolbar menu,
    #placesToolbar button,
    #placesToolbar toolbarbutton {
      color: var(--white) !important;
      fill: var(--white) !important;
    }

    #placesMenu menu:hover,
    #placesToolbar button:hover,
    #placesToolbar toolbarbutton:hover {
      appearance: none !important;
      -moz-appearance: none !important;
      background-color: var(--bbackground) !important;
      border-color: var(--bbackground) !important;
      border-radius: 6px !important;
    }

    input {
      background-color: var(--background) !important;
      color: var(--white) !important;
      border: 1px solid var(--bbackground) !important;
      border-radius: 6px !important;
    }

    input:focus {
      border-color: var(--cyan) !important;
      outline: none !important;
    }

    #detailsPane input {
      background-color: var(--foreground) !important;
      color: var(--white) !important;
      border: 1px solid var(--bbackground) !important;
      border-radius: 6px !important;
    }
    #detailsPane input:focus {
      border-color: var(--cyan) !important;
    }

    splitter {
      min-width: 1px !important;
      background-color: var(--bbackground) !important;
      border-right-style: none !important;
      border-left-style: none !important;
    }

    .tree-splitter {
      background: linear-gradient(
        90deg,
        transparent 4px,
        var(--bbackground) 5px 5px,
        transparent 5px
      ) !important;
    }

    treecol {
      background-color: var(--foreground) !important;
      color: var(--white) !important;
      border-top: 1px solid var(--bbackground) !important;
      border-bottom: 1px solid var(--bbackground) !important;
      box-shadow: none !important;
    }

    treechildren::-moz-tree-row(hover),
    treechildren::-moz-tree-row(selected) {
      background-color: var(--bbackground) !important;
    }

    treechildren::-moz-tree-cell-text(selected) {
      color: var(--white) !important;
    }

    treechildren::-moz-tree-image,
    treechildren::-moz-tree-image(selected),
    treechildren::-moz-tree-twisty {
      fill: var(--white) !important;
    }

    treechildren::-moz-tree-row(selected) {
      outline: none !important;
    }
  }

  /* ===================
     Add bookmark window
     =================== */
  @-moz-document url("chrome://browser/content/places/bookmarkProperties.xhtml"),
                url-prefix("chrome://browser/content/places/bookmarkProperties")
  {
    window {
      background-color: var(--background) !important;
      color: var(--white) !important;
    }

    input {
      background-color: var(--foreground) !important;
      color: var(--white) !important;
      border: 1px solid var(--bbackground) !important;
    }

    input:focus {
      border-color: var(--cyan) !important;
    }

    #editBMPanel_tagsSelector,
    button {
      appearance: none !important;
      -moz-appearance: none !important;
      background-color: var(--foreground) !important;
      color: var(--white) !important;
      border: 1px solid var(--bbackground) !important;
      border-radius: 6px !important;
    }

    button:hover {
      background-color: var(--bbackground) !important;
    }

    button[dlgtype="cancel"]:hover {
      background-color: var(--red) !important;
      border-color: var(--red) !important;
      color: var(--foreground) !important;
    }

    button[dlgtype="accept"]:hover {
      background-color: var(--cyan) !important;
      border-color: var(--cyan) !important;
      color: var(--foreground) !important;
    }
  }
''
