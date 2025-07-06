{
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-others.css" = {
    text = ''
      /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/overlay_sidebar_header.css made available under Mozilla Public License v. 2.0
      See the above repository for updates as well as full license text. */

      /* This is a hack that only "kinda" works! */
      /* Changes sidebar header to appear as small "notch" at the top of the sidebar. Hovering it will show full sidebar so you can have access to sidebar switcher button. The caveat is that you need to click the switcher button TWICE - otherwise the header and switcher popup will hide themselver as soon as cursor is moved on top of the switcher popup. */

      #sidebar-header{
        display: flex;
        position: absolute;
        width: inherit;
        visibility: hidden;
        background-color: inherit;
        -moz-user-focus: normal;
        z-index: 100;
      }
      #sidebar-header::before{
        visibility: visible;
        content: "";
        position: absolute;
        top: 0;
        right: 0;
        width: 20px;
        height: 20px;
        background: #27a1b9; /* Cyan color */
        clip-path: polygon(0% 0%, 100% 0%, 100% 100%);
      }
      #sidebar-switcher-target.active{
        pointer-events: none;
      }
      #sidebar-header:focus-within,
      #sidebar-header:hover{
        visibility: visible;
      }
      #sidebar-spacer{
        flex-grow: 1;
      }

      /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_statuspanel_when_fullscreen.css made available under Mozilla Public License v. 2.0
      See the above repository for updates as well as full license text. */

      /* Always hide status-panel when the page is in fullscreen mode such as fullscreen video player */
      /* No effect on Firefox fullscreen mode (activated with F11 key) - except when the page is in fullscreen */

      :root[inDOMFullscreen] #statuspanel{ display: none !important }

      /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/more_visible_tab_icon.css made available under Mozilla Public License v. 2.0
      See the above repository for updates as well as full license text. */

      /* Makes black favicons more visible on dark background, contrast will be lowered though */
      .tab-icon-image{
        filter: invert(40%) contrast(250%) saturate(250%) !important;
      }

      /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_urlbar_first_row.css made available under Mozilla Public License v. 2.0
      See the above repository for updates as well as full license text. */

      /* Hides the first item in the urlbar dropdown if it is a "search with" or "visit" or "tab-to-search" item.  Does not hide "search in private window item", probably */

      #urlbar[usertyping] .urlbarView-row:is([type="url"],[type="autofill_origin"],[type="search"]):first-child,
      .urlbarView-row[type="tabtosearch"] {
        display: none !important;
      }
    '';
  };
}
