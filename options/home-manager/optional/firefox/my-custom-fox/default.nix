{
  config,
  homes,
  hosts,
  lib,
  mylib,
  pkgs,
  ...
}: let
  doh =
    if !hosts.dnscrypt
    then ''
      user_pref("network.trr.mode", 3);
      user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
    ''
    else "";
  sidebar =
    if homes.firefox.verticaltab.enable
    then
      ''
        user_pref("browser.uiCustomization.horizontalTabsBackup", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":3}");
        user_pref("browser.uiCustomization.horizontalTabstrip", "[\"tabbrowser-tabs\"]");
        user_pref("browser.uiCustomization.navBarWhenVerticalTabs", "[\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"]");
        user_pref("sidebar.animation.expand-on-hover.delay-duration-ms", 0);
        user_pref("sidebar.animation.expand-on-hover.duration-ms", 200);
        user_pref("sidebar.main.tools", "");
        user_pref("sidebar.new-sidebar.has-used", true);
        user_pref("sidebar.revamp", true);
        user_pref("sidebar.verticalTabs", true);
        user_pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
        user_pref("sidebar.visibility", "expand-on-hover");
      ''
      + (
        if homes.firefox.verticaltab.position == "left"
        then ''
          user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":4}");
          user_pref("sidebar.position_start", true);
        ''
        else ''
          user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\",\"sidebar-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":4}");
          user_pref("sidebar.position_start", false);
        ''
      )
    else ''
      user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[],\"vertical-tabs\":[\"tabbrowser-tabs\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":4}");
      user_pref("sidebar.main.tools", "syncedtabs,history,bookmarks");
      user_pref("sidebar.position_start", false);
      user_pref("sidebar.visibility", "hide-sidebar");
    '';
in {
  imports = mylib.autoimport ./.;

  home.file.".mozilla/firefox/${hosts.username}/user.js" = lib.mkIf homes.firefox.enable {
    text = ''
      //
      /* You may copy+paste this file and use it as it is.
       *
       * If you make changes to your about:config while the program is running, the
       * changes will be overwritten by the user.js when the application restarts.
       *
       * To make lasting changes to preferences, you will have to edit the user.js.
       */

      /****************************************************************************
       * Betterfox                                                                *
       * "Ad meliora"                                                             *
       * version: 146                                                             *
       * url: https://github.com/yokoffing/Betterfox                              *
      ****************************************************************************/

      /****************************************************************************
       * SECTION: FASTFOX                                                         *
      ****************************************************************************/
      /** GENERAL ***/
      user_pref("gfx.content.skia-font-cache-size", 32);

      /** GFX ***/
      user_pref("gfx.webrender.layer-compositor", true);
      user_pref("gfx.canvas.accelerated.cache-items", 32768);
      user_pref("gfx.canvas.accelerated.cache-size", 4096);
      user_pref("webgl.max-size", 16384);

      /** DISK CACHE ***/
      user_pref("browser.cache.disk.enable", false);

      /** MEMORY CACHE ***/
      user_pref("browser.cache.memory.capacity", 131072);
      user_pref("browser.cache.memory.max_entry_size", 20480);
      user_pref("browser.sessionhistory.max_total_viewers", 4);
      user_pref("browser.sessionstore.max_tabs_undo", 10);

      /** MEDIA CACHE ***/
      user_pref("media.memory_cache_max_size", 262144);
      user_pref("media.memory_caches_combined_limit_kb", 1048576);
      user_pref("media.cache_readahead_limit", 600);
      user_pref("media.cache_resume_threshold", 300);

      /** IMAGE CACHE ***/
      user_pref("image.cache.size", 10485760);
      user_pref("image.mem.decode_bytes_at_a_time", 65536);

      /** NETWORK ***/
      user_pref("network.http.max-connections", 1800);
      user_pref("network.http.max-persistent-connections-per-server", 10);
      user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
      user_pref("network.http.request.max-start-delay", 5);
      user_pref("network.http.pacing.requests.enabled", false);
      user_pref("network.dnsCacheEntries", 10000);
      user_pref("network.dnsCacheExpiration", 3600);
      user_pref("network.ssl_tokens_cache_capacity", 10240);

      /** SPECULATIVE LOADING ***/
      user_pref("network.http.speculative-parallel-limit", 0);
      user_pref("network.dns.disablePrefetch", true);
      user_pref("network.dns.disablePrefetchFromHTTPS", true);
      user_pref("browser.urlbar.speculativeConnect.enabled", false);
      user_pref("browser.places.speculativeConnect.enabled", false);
      user_pref("network.prefetch-next", false);

      /****************************************************************************
       * SECTION: SECUREFOX                                                       *
      ****************************************************************************/
      /** TRACKING PROTECTION ***/
      user_pref("browser.contentblocking.category", "strict");
      user_pref("browser.download.start_downloads_in_tmp_dir", true);
      user_pref("browser.uitour.enabled", false);
      user_pref("privacy.globalprivacycontrol.enabled", true);

      /** OCSP & CERTS / HPKP ***/
      user_pref("security.OCSP.enabled", 0);
      user_pref("privacy.antitracking.isolateContentScriptResources", true);
      user_pref("security.csp.reporting.enabled", false);

      /** SSL / TLS ***/
      user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
      user_pref("browser.xul.error_pages.expert_bad_cert", true);
      user_pref("security.tls.enable_0rtt_data", false);

      /** DISK AVOIDANCE ***/
      user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
      user_pref("browser.sessionstore.interval", 60000);

      /** SHUTDOWN & SANITIZING ***/
      user_pref("privacy.history.custom", true);
      user_pref("browser.privatebrowsing.resetPBM.enabled", true);

      /** SEARCH / URL BAR ***/
      user_pref("browser.urlbar.trimHttps", true);
      user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
      user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
      user_pref("browser.search.suggest.enabled", false);
      user_pref("browser.urlbar.quicksuggest.enabled", false);
      user_pref("browser.urlbar.groupLabels.enabled", false);
      user_pref("browser.formfill.enable", false);
      user_pref("network.IDN_show_punycode", true);

      /** HTTPS-ONLY MODE ***/
      user_pref("dom.security.https_only_mode", true);
      user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

      /** PASSWORDS ***/
      user_pref("signon.formlessCapture.enabled", false);
      user_pref("signon.privateBrowsingCapture.enabled", false);
      user_pref("network.auth.subresource-http-auth-allow", 1);
      user_pref("editor.truncate_user_pastes", false);

      /** EXTENSIONS ***/
      user_pref("extensions.enabledScopes", 5);

      /** HEADERS / REFERERS ***/
      user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

      /** CONTAINERS ***/
      user_pref("privacy.userContext.ui.enabled", true);

      /** VARIOUS ***/
      user_pref("pdfjs.enableScripting", false);

      /** SAFE BROWSING ***/
      user_pref("browser.safebrowsing.downloads.remote.enabled", false);

      /** MOZILLA ***/
      user_pref("permissions.default.desktop-notification", 2);
      user_pref("permissions.default.geo", 2);
      user_pref("geo.provider.network.url", "https://beacondb.net/v1/geolocate");
      user_pref("browser.search.update", false);
      user_pref("permissions.manager.defaultsUrl", "");
      user_pref("extensions.getAddons.cache.enabled", false);

      /** TELEMETRY ***/
      user_pref("datareporting.policy.dataSubmissionEnabled", false);
      user_pref("datareporting.healthreport.uploadEnabled", false);
      user_pref("toolkit.telemetry.unified", false);
      user_pref("toolkit.telemetry.enabled", false);
      user_pref("toolkit.telemetry.server", "data:,");
      user_pref("toolkit.telemetry.archive.enabled", false);
      user_pref("toolkit.telemetry.newProfilePing.enabled", false);
      user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
      user_pref("toolkit.telemetry.updatePing.enabled", false);
      user_pref("toolkit.telemetry.bhrPing.enabled", false);
      user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
      user_pref("toolkit.telemetry.coverage.opt-out", true);
      user_pref("toolkit.coverage.opt-out", true);
      user_pref("toolkit.coverage.endpoint.base", "");
      user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
      user_pref("browser.newtabpage.activity-stream.telemetry", false);
      user_pref("datareporting.usage.uploadEnabled", false);

      /** EXPERIMENTS ***/
      user_pref("app.shield.optoutstudies.enabled", false);
      user_pref("app.normandy.enabled", false);
      user_pref("app.normandy.api_url", "");

      /** CRASH REPORTS ***/
      user_pref("breakpad.reportURL", "");
      user_pref("browser.tabs.crashReporting.sendReport", false);

      /****************************************************************************
       * SECTION: PESKYFOX                                                        *
      ****************************************************************************/
      /** MOZILLA UI ***/
      user_pref("extensions.getAddons.showPane", false);
      user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
      user_pref("browser.discovery.enabled", false);
      user_pref("browser.shell.checkDefaultBrowser", false);
      user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
      user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
      user_pref("browser.preferences.moreFromMozilla", false);
      user_pref("browser.aboutConfig.showWarning", false);
      user_pref("browser.startup.homepage_override.mstone", "ignore");
      user_pref("browser.aboutwelcome.enabled", false);
      user_pref("browser.profiles.enabled", true);

      /** THEME ADJUSTMENTS ***/
      user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      user_pref("browser.compactmode.show", true);
      user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

      /** AI ***/
      user_pref("browser.ml.enable", false);
      user_pref("browser.ml.chat.enabled", false);
      user_pref("browser.ml.chat.menu", false);
      user_pref("browser.tabs.groups.smart.enabled", false);
      user_pref("browser.ml.linkPreview.enabled", false);

      /** FULLSCREEN NOTICE ***/
      user_pref("full-screen-api.transition-duration.enter", "0 0");
      user_pref("full-screen-api.transition-duration.leave", "0 0");
      user_pref("full-screen-api.warning.timeout", 0);

      /** URL BAR ***/
      user_pref("browser.urlbar.trending.featureGate", false);

      /** NEW TAB PAGE ***/
      user_pref("browser.newtabpage.activity-stream.default.sites", "");
      user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
      user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
      user_pref("browser.newtabpage.activity-stream.showSponsored", false);
      user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

      /** DOWNLOADS ***/
      user_pref("browser.download.manager.addToRecentDocs", false);

      /** PDF ***/
      user_pref("browser.download.open_pdf_attachments_inline", true);

      /** TAB BEHAVIOR ***/
      user_pref("browser.bookmarks.openInTabClosesMenu", false);
      user_pref("browser.menu.showViewImageInfo", true);
      user_pref("findbar.highlightAll", true);
      user_pref("layout.word_select.eat_space_to_next_word", false);

      /****************************************************************************
       * START: MY OVERRIDES                                                      *
      ****************************************************************************/
      // visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
      // visit https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
      // Enter your personal overrides below this line:

      user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
      user_pref("devtools.chrome.enabled", true);
      user_pref("devtools.debugger.remote-enabled", true);
      user_pref("devtools.debugger.prompt-connection", false);
      user_pref("mousewheel.default.delta_multiplier_y", 250); // 250-400; adjust this number to your liking
      user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
      user_pref("toolkit.telemetry.shutdownPingSender.enabledFirstsession", false);
      user_pref("webgl.disabled", true);
      ${doh}
      ${sidebar}
      /****************************************************************************
       * SECTION: SMOOTHFOX                                                       *
      ****************************************************************************/
      // visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
      // Enter your scrolling overrides below this line:



      /****************************************************************************
       * END: BETTERFOX                                                           *
      ****************************************************************************/
    '';
  };
  home.activation.resetfirefoxprefs = lib.hm.dag.entryAfter ["writeBoundary"] ''
    VERTICALTAB_ENABLE="${lib.boolToString homes.firefox.verticaltab.enable}"
    VERTICALTAB_POSITION="${homes.firefox.verticaltab.position}"
    VERTICALTAB_FILE="${config.home.homeDirectory}/.cache/${hosts.username}/verticaltab"
    PREFS="${config.home.homeDirectory}/.mozilla/firefox/${hosts.username}/prefs.js"

    if [[ ! -f "$VERTICALTAB_FILE" ]]; then
      echo "$VERTICALTAB_ENABLE" > "$VERTICALTAB_FILE"
      echo "$VERTICALTAB_POSITION" >> "$VERTICALTAB_FILE"
    else
      VERTICALTAB_ENABLE_OLD=$(sed -n "1p" $VERTICALTAB_FILE)
      VERTICALTAB_POSITION_OLD=$(sed -n "2p" $VERTICALTAB_FILE)

      if [[ "$VERTICALTAB_ENABLE" != "$VERTICALTAB_ENABLE_OLD" ]] || [[ "$VERTICALTAB_POSITION" != "$VERTICALTAB_POSITION_OLD" ]]; then
        ${pkgs.procps}/bin/pkill firefox || true
        if [[ -f "$PREFS" ]]; then
          sed -i '/^user_pref("browser.uiCustomization\./d' "$PREFS"
          sed -i '/^user_pref("sidebar\./d' "$PREFS"
        fi
        sed -i "1c $VERTICALTAB_ENABLE" "$VERTICALTAB_FILE"
        sed -i "2c $VERTICALTAB_POSITION" "$VERTICALTAB_FILE"
      fi
    fi
  '';
}
