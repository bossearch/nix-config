{config, ...}: ''
  /* make dropdown menu list is dark mode */
  #ContentSelectDropdownPopup {
    color-scheme: dark !important;
  }

  /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_statuspanel_when_fullscreen.css made available under Mozilla Public License v. 2.0
  See the above repository for updates as well as full license text. */

  /* Always hide status-panel when the page is in fullscreen mode such as fullscreen video player */
  /* No effect on Firefox fullscreen mode (activated with F11 key) - except when the page is in fullscreen */

  :root[inDOMFullscreen] #statuspanel {
    display: none !important;
  }

  /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/more_visible_tab_icon.css made available under Mozilla Public License v. 2.0
  See the above repository for updates as well as full license text. */

  /* Makes black favicons more visible on dark background, contrast will be lowered though */
  .tab-icon-image {
    filter: invert(40%) contrast(250%) saturate(250%) !important;
  }

  /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_urlbar_first_row.css made available under Mozilla Public License v. 2.0
  See the above repository for updates as well as full license text. */

  /* Hides the first item in the urlbar dropdown if it is a "search with" or "visit" or "tab-to-search" item.  Does not hide "search in private window item", probably */

  #urlbar[usertyping]
    .urlbarView-row:is(
      [type="url"],
      [type="autofill_origin"],
      [type="search"]
    ):first-child,
  .urlbarView-row[type="tabtosearch"] {
    display: none !important;
  }
''
