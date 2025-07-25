{config, ...}: {
  home.file.".mozilla/firefox/${config.spec.userName}/chrome/includes/custom-compact.css" = {
    text = ''
      /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/compact_extensions_panel.css made available under Mozilla Public License v. 2.0
      See the above repository for updates as well as full license text. */

      /* This style hides some information from the extensions-button panel, but makes it appear more compact. Might be useful for someone having lot of extensions */

      #unified-extensions-view{
        --uei-icon-size: 16px;
      }
      .unified-extensions-item-menu-button.subviewbutton{
        padding: 0px !important;
        margin-inline-end: 0 !important;
      }
      .unified-extensions-item-action-button.subviewbutton{
        padding-block: 6px !important;
      }
      .unified-extensions-item-menu-button.subviewbutton > .toolbarbutton-icon{
        padding: 4px !important;
      }
      .unified-extensions-item-message-deck{
        display: none
      }
      #unified-extensions-view > vbox > vbox > .unified-extensions-item{
        padding-block: 0px !important;
      }
      #unified-extensions-panel .unified-extensions-item{
        margin-block: 0 !important;
      }
    '';
  };
}
