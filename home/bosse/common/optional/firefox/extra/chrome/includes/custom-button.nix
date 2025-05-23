{...}: {
  home.file.".mozilla/firefox/bosse/chrome/includes/custom-button.css" = {
    text = ''
      /* Removes the annoying rainbow thing from the hamburger  */
      #appMenu-fxa-separator{border-image:none !important;}

      /* Removes X buttons and spaces */
      .titlebar-buttonbox-container { display: none !important; }
      .titlebar-spacer[type="pre-tabs"], .titlebar-spacer[type="post-tabs"]{display: none !important}
      #tabbrowser-tabs{border-inline-start-width: 0!important}

      /* Removes shield buttons in the urlbar */
      #tracking-protection-icon-container { display: none !important; }

      /* Only hides permission items */
      /*
      #identity-permission-box { display: none !important; }
      */

      /* Hides encryption and permission items */
      /* #identity-box { display: none !important }
      */

      /* Remove search engine indicator box inside the URL bar */
      #urlbar-search-mode-indicator { display: none !important; }

      /* Remove Container Tab labels inside the URL bar */
      #userContext-icons { display: none !important; }

      /* Remove »Go«-arrow in the URL Bar */
      #urlbar-go-button { display: none !important; }

      /* Removes all buttons on the right inside urlbar */
      /*
      .urlbar-page-action { display: none !important; }
      */

      /* Remove translations button */
      /*
      #translations-button { display: none !important; }
      */

      /* Remove reader mode button */
      /*
      #reader-mode-button { display: none !important; }
      */

      /* Remove star or bookmark button */
      #star-button-box { display: none !important; }

      /* Hide the Side View button */
      #pageAction-urlbar-side-view_mozilla_org {
          display: none !important;
      }

      /* Hides the list-all-tabs button*/
      #alltabs-button { display: none !important; }

      /* Hides the Extensions Menu Icon */
      /*
      #unified-extensions-button { display: none !important; }
      */

      /* Makes some buttons nicer  */
      #PanelUI-menu-button, #unified-extensions-button, #reload-button, #stop-button {padding: 0px !important}

      /* Removes the private-browsing-mode indicator from tabs toolbar and changes the menu-button icon to the private-browsing indicator in private windows */
      .private-browsing-indicator-with-label { display: none !important }
      :root[privatebrowsingmode="temporary"] #PanelUI-menu-button{
        list-style-image: url("chrome://global/skin/icons/indicator-private-browsing.svg") !important;
      }
    '';
  };
}
