{...}: ''
  /* Removes the annoying rainbow thing from the hamburger  */
  #appMenu-fxa-status2,
  #appMenu-fxa-separator {
    display: none !important;
  }

  /* Removes X buttons and spaces */
  .titlebar-buttonbox-container {
    display: none !important;
  }
  .titlebar-spacer[type="pre-tabs"],
  .titlebar-spacer[type="post-tabs"] {
    display: none !important;
  }
  #tabbrowser-tabs {
    border-inline-start-width: 0 !important;
  }

  /* Remove Container Tab labels inside the URL bar */
  #userContext-icons {
    display: none !important;
  }

  /* Remove »Go«-arrow in the URL Bar */
  #urlbar-go-button {
    display: none !important;
  }

  /* Remove star or bookmark button without breaking panel anchor */
  #star-button-box {
    position: absolute !important;
    opacity: 0 !important;
    pointer-events: none !important;
  }

  /* Makes some buttons nicer  */
  #PanelUI-menu-button,
  #unified-extensions-button,
  #reload-button,
  #stop-button {
    padding: 0px !important;
  }

  /* Removes the private-browsing-mode indicator from tabs toolbar and changes the menu-button icon to the private-browsing indicator in private windows */
  .private-browsing-indicator-with-label {
    display: none !important;
  }
  :root[privatebrowsingmode="temporary"] #PanelUI-menu-button {
    list-style-image: url("chrome://global/skin/icons/indicator-private-browsing.svg") !important;
  }
''
