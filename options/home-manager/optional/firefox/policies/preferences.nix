{
  # TELEMETRY, PROMOS & MOZILLA SERVICES
  # Disables Ping Centre telemetry data sent to Mozilla
  "browser.ping-centre.telemetry" = {
    Value = false;
    Status = "default";
  };
  # Hides Mozilla VPN marketing banners across browser settings
  "browser.vpn_promo.enabled" = {
    Value = false;
    Status = "default";
  };
  # Disables OS-level geolocation providers (Windows, macOS CoreLocation, Linux GeoClue & GPSD)
  "geo.provider.ms-windows-location" = {
    Value = false;
    Status = "default";
  };
  "geo.provider.use_corelocation" = {
    Value = false;
    Status = "default";
  };
  "geo.provider.use_geoclue" = {
    Value = false;
    Status = "default";
  };
  "geo.provider.use_gpsd" = {
    Value = false;
    Status = "default";
  };

  # PRIVACY, SECURITY & NETWORKING
  # Enforces HTTPS-only mode across all windows
  "dom.security.https_only_mode" = {
    Value = true;
    Status = "default";
  };
  # Completely disables WebRTC (prevents real IP leaks, disables browser voice/video calls)
  "media.peerconnection.enabled" = {
    Value = true;
    Status = "default";
  };
  # Sends 'Sec-GPC: 1' header asking sites not to sell/share data (Global Privacy Control)
  "privacy.globalprivacycontrol.enabled" = {
    Value = true;
    Status = "default";
  };
  # Prevents sites from relaxing strict cross-site referrer policies on top-level navigation
  "network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = {
    Value = true;
    Status = "default";
  };
  # Removes Mozilla domain restrictions, allowing extensions (like uBlock) to run on addons.mozilla.org
  "extensions.webextensions.restrictedDomains" = {
    Value = "";
    Status = "default";
    Type = "string";
  };
  # Disables Google Safe Browsing malware & phishing checks (stops sending file hash queries to Google)
  "browser.safebrowsing.malware.enabled" = {
    Value = false;
    Status = "default";
  };
  "browser.safebrowsing.phishing.enabled" = {
    Value = false;
    Status = "default";
  };

  # ==========================================
  # UI, THEME & NEW TAB PAGE
  # ==========================================
  # Applies Compact UI Density (0=Normal, 1=Compact, 2=Touch)
  "browser.uidensity" = {
    Value = 1;
    Status = "default";
    Type = "number";
  };
  # Hides the Bookmarks Toolbar ("always", "never", "newtab")
  "browser.toolbars.bookmarks.visibility" = {
    Value = "never";
    Status = "default";
    Type = "string";
  };
  # Forces dark theme for internal toolbars & web content (0=Dark, 1=Light, 2=System)
  "browser.theme.toolbar-theme" = {
    Value = 0;
    Status = "default";
    Type = "number";
  };
  "browser.theme.content-theme" = {
    Value = 0;
    Status = "default";
    Type = "number";
  };
  "layout.css.prefers-color-scheme.content-override" = {
    Value = 0;
    Status = "default";
    Type = "number";
  };
  "extensions.activeThemeID" = {
    Value = "firefox-compact-dark@mozilla.org";
    Status = "default";
    Type = "string";
  };
  # Disables Top Sites feed & sponsored shortcut toggles on the New Tab page
  "browser.newtabpage.activity-stream.feeds.topsites" = {
    Value = false;
    Status = "default";
  };
  "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = {
    Value = false;
    Status = "default";
  };
  # Disables tab thumbnail cards when hovering over open tabs
  "browser.tabs.hoverPreview.enabled" = {
    Value = false;
    Status = "default";
  };
  "browser.tabs.hoverPreview.showThumbnails" = {
    Value = false;
    Status = "default";
  };
  # Disables warning prompt when using Ctrl+Q / Cmd+Q quit shortcut
  "browser.warnOnQuitShortcut" = {
    Value = false;
    Status = "default";
  };
  # Loading userChrome.css / userContent.css custom stylesheets
  "toolkit.legacyUserProfileCustomizations.stylesheets" = {
    Value = true;
    Status = "default";
  };

  # ==========================================
  # ADDRESS BAR (URLBAR) & SEARCH
  # ==========================================
  # Retains https:// protocol prefix in URL bar display instead of hiding it
  "browser.urlbar.trimURLs" = {
    Value = true;
    Status = "default";
  };
  # Disables using a separate default search engine in Private Windows
  "browser.search.separatePrivateDefault" = {
    Value = false;
    Status = "default";
  };
  # Disables quick action buttons, search engine buttons, and top sites in address bar dropdown
  "browser.urlbar.shortcuts.actions" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.shortcuts.bookmarks" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.shortcuts.history" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.shortcuts.tabs" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.suggest.engines" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.suggest.quickactions" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.suggest.topsites" = {
    Value = false;
    Status = "default";
  };
  # Disables sponsored & non-sponsored Firefox Suggest cloud results in the address bar
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = {
    Value = false;
    Status = "default";
  };
  "browser.urlbar.suggest.quicksuggest.sponsored" = {
    Value = false;
    Status = "default";
  };

  # ==========================================
  # PERFORMANCE & SMOOTH SCROLLING
  # ==========================================
  # Unchecks default performance settings box (allows process count & HWA customization)
  "browser.preferences.defaultPerformanceSettings.enabled" = {
    Value = false;
    Status = "default";
  };
  # Enables middle-click auto-scrolling
  "general.autoScroll" = {
    Value = true;
    Status = "default";
  };
  # Enables Mass-Spring-Damper (MSD) custom smooth scrolling physics engine
  "general.smoothScroll" = {
    Value = true;
    Status = "default";
  };
  "general.smoothScroll.msdPhysics.enabled" = {
    Value = true;
    Status = "default";
  };
  "general.smoothScroll.currentVelocityWeighting" = {
    Value = "1";
    Status = "default";
    Type = "string";
  };
  "general.smoothScroll.stopDecelerationWeighting" = {
    Value = "1";
    Status = "default";
    Type = "string";
  };
  "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = {
    Value = 12;
    Status = "default";
    Type = "number";
  };
  "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = {
    Value = 600;
    Status = "default";
    Type = "number";
  };
  "general.smoothScroll.msdPhysics.regularSpringConstant" = {
    Value = 650;
    Status = "default";
    Type = "number";
  };
  "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = {
    Value = 25;
    Status = "default";
    Type = "number";
  };
  "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = {
    Value = "2";
    Status = "default";
    Type = "string";
  };
  "general.smoothScroll.msdPhysics.slowdownSpringConstant" = {
    Value = 250;
    Status = "default";
    Type = "number";
  };

  # ==========================================
  # MISCELLANEOUS / CONTAINERS
  # ==========================================
  # Disables Firefox Multi-Account Containers integration
  "privacy.userContext.enabled" = {
    Value = false;
    Status = "default";
  };
  "privacy.userContext.ui.enabled" = {
    Value = false;
    Status = "default";
  };
  # Hides experimental section in about:preferences
  "browser.preferences.experimental.hidden" = {
    Value = true;
    Status = "default";
  };
  # Mutes Web Speech API notification errors
  "media.webspeech.synth.dont_notify_on_error" = {
    Value = true;
    Status = "default";
  };
}
