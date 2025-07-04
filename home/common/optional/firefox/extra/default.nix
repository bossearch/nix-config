{
  imports = [
    ./chrome
  ];
  home.file.".mozilla/firefox/bosse/user.js" = {
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
       * version: 137                                                             *
       * url: https://github.com/yokoffing/Betterfox                              *
      ****************************************************************************/

      /****************************************************************************
       * SECTION: FASTFOX                                                         *
      ****************************************************************************/
      /** GENERAL ***/
      user_pref("content.notify.interval", 100000);

      /** GFX ***/
      user_pref("gfx.canvas.accelerated.cache-size", 512);
      user_pref("gfx.content.skia-font-cache-size", 20);

      /** DISK CACHE ***/
      user_pref("browser.cache.disk.enable", false);

      /** MEDIA CACHE ***/
      user_pref("media.memory_cache_max_size", 65536);
      user_pref("media.cache_readahead_limit", 7200);
      user_pref("media.cache_resume_threshold", 3600);

      /** IMAGE CACHE ***/
      user_pref("image.mem.decode_bytes_at_a_time", 32768);

      /** NETWORK ***/
      user_pref("network.http.max-connections", 1800);
      user_pref("network.http.max-persistent-connections-per-server", 10);
      user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
      user_pref("network.http.pacing.requests.enabled", false);
      user_pref("network.dnsCacheExpiration", 3600);
      user_pref("network.ssl_tokens_cache_capacity", 10240);

      /** SPECULATIVE LOADING ***/
      user_pref("network.dns.disablePrefetch", true);
      user_pref("network.dns.disablePrefetchFromHTTPS", true);
      user_pref("network.prefetch-next", false);
      user_pref("network.predictor.enabled", false);
      user_pref("network.predictor.enable-prefetch", false);

      /** EXPERIMENTAL ***/
      user_pref("layout.css.grid-template-masonry-value.enabled", true);

      /****************************************************************************
       * SECTION: SECUREFOX                                                       *
      ****************************************************************************/
      /** TRACKING PROTECTION ***/
      user_pref("browser.contentblocking.category", "strict");
      user_pref("browser.download.start_downloads_in_tmp_dir", true);
      user_pref("browser.helperApps.deleteTempFileOnExit", true);
      user_pref("browser.uitour.enabled", false);
      user_pref("privacy.globalprivacycontrol.enabled", true);

      /** OCSP & CERTS / HPKP ***/
      user_pref("security.OCSP.enabled", 0);
      user_pref("security.pki.crlite_mode", 2);

      /** SSL / TLS ***/
      user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
      user_pref("browser.xul.error_pages.expert_bad_cert", true);
      user_pref("security.tls.enable_0rtt_data", false);

      /** DISK AVOIDANCE ***/
      user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
      user_pref("browser.sessionstore.interval", 60000);

      /** SHUTDOWN & SANITIZING ***/
      user_pref("browser.privatebrowsing.resetPBM.enabled", true);
      user_pref("privacy.history.custom", true);

      /** SEARCH / URL BAR ***/
      user_pref("browser.urlbar.trimHttps", true);
      user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
      user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
      user_pref("browser.urlbar.update2.engineAliasRefresh", true);
      user_pref("browser.search.suggest.enabled", false);
      user_pref("browser.urlbar.quicksuggest.enabled", false);
      user_pref("browser.urlbar.groupLabels.enabled", false);
      user_pref("browser.formfill.enable", false);
      user_pref("network.IDN_show_punycode", true);

      /** PASSWORDS ***/
      user_pref("signon.formlessCapture.enabled", false);
      user_pref("signon.privateBrowsingCapture.enabled", false);
      user_pref("network.auth.subresource-http-auth-allow", 1);
      user_pref("editor.truncate_user_pastes", false);

      /** MIXED CONTENT + CROSS-SITE ***/
      user_pref("security.mixed_content.block_display_content", true);
      user_pref("pdfjs.enableScripting", false);

      /** EXTENSIONS ***/
      user_pref("extensions.enabledScopes", 5);

      /** HEADERS / REFERERS ***/
      user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

      /** CONTAINERS ***/
      user_pref("privacy.userContext.ui.enabled", true);

      /** SAFE BROWSING ***/
      user_pref("browser.safebrowsing.downloads.remote.enabled", false);

      /** MOZILLA ***/
      user_pref("permissions.default.desktop-notification", 2);
      user_pref("permissions.default.geo", 2);
      user_pref("geo.provider.network.url", "https://beacondb.net/v1/geolocate");
      user_pref("browser.search.update", false);
      user_pref("permissions.manager.defaultsUrl", "");

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

      /** EXPERIMENTS ***/
      user_pref("app.shield.optoutstudies.enabled", false);
      user_pref("app.normandy.enabled", false);
      user_pref("app.normandy.api_url", "");

      /** CRASH REPORTS ***/
      user_pref("breakpad.reportURL", "");
      user_pref("browser.tabs.crashReporting.sendReport", false);

      /** DETECTION ***/
      user_pref("captivedetect.canonicalURL", "");
      user_pref("network.captive-portal-service.enabled", false);
      user_pref("network.connectivity-service.enabled", false);

      /****************************************************************************
       * SECTION: PESKYFOX                                                        *
      ****************************************************************************/
      /** MOZILLA UI ***/
      user_pref("browser.privatebrowsing.vpnpromourl", "");
      user_pref("extensions.getAddons.showPane", false);
      user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
      user_pref("browser.discovery.enabled", false);
      user_pref("browser.shell.checkDefaultBrowser", false);
      user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
      user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
      user_pref("browser.preferences.moreFromMozilla", false);
      user_pref("browser.aboutConfig.showWarning", false);
      user_pref("browser.aboutwelcome.enabled", false);
      user_pref("browser.profiles.enabled", true);

      /** THEME ADJUSTMENTS ***/
      user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

      /** FULLSCREEN NOTICE ***/
      user_pref("full-screen-api.transition-duration.enter", "0 0");
      user_pref("full-screen-api.transition-duration.leave", "0 0");
      user_pref("full-screen-api.warning.timeout", 0);

      /** URL BAR ***/
      user_pref("browser.urlbar.unitConversion.enabled", true);
      user_pref("browser.urlbar.trending.featureGate", false);
      user_pref("dom.text_fragments.create_text_fragment.enabled", true);

      /** NEW TAB PAGE ***/
      user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

      /** POCKET ***/
      user_pref("extensions.pocket.enabled", false);

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

      // move sidebar to the right
      user_pref("sidebar.position_start", false);
      // disable webgl
      user_pref("webgl.disabled", true);
      // trim url
      user_pref("browser.urlbar.trimURLs", true);
      // disable new sidebar
      user_pref("sidebar.revamp", false);
      // show profile management in hamburger menu

      // show compact mode
      user_pref("browser.compactmode.show", true);
      user_pref("browser.uidensity", 1);
      //0: Default UI (standard spacing).
      //1: Compact UI (elements are packed closer together).
      //2: Spacious UI (elements are more spread out).
      // disable sync data login
      user_pref("identity.fxaccounts.enabled", false);

      // theme & toolbar
      user_pref("browser.theme.content-theme", 0);
      user_pref("browser.theme.toolbar-theme", 0);
      user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"sponsorblocker_ajay_app-browser-action\",\"newtaboverride_agenedia_com-browser-action\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"side-view_mozilla_org-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\"],\"nav-bar\":[\"back-button\",\"stop-reload-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"save-to-pocket-button\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"addon_darkreader_org-browser-action\",\"78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action\",\"ublock0_raymondhill_net-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"side-view_mozilla_org-browser-action\",\"newtaboverride_agenedia_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"addon_darkreader_org-browser-action\",\"extension_one-tab_com-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"unified-extensions-area\",\"TabsToolbar\"],\"currentVersion\":22,\"newElementCount\":4}");
      user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
      user_pref("devtools.chrome.enabled", false);
      user_pref("devtools.debugger.remote-enabled", false);

      user_pref("browser.engagement.home-button.has-removed", true);
      user_pref("browser.engagement.home-button.has-used", true);
      user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
      user_pref("browser.safebrowsing.downloads.enabled", false);
      user_pref("browser.safebrowsing.malware.enabled", false);
      user_pref("browser.safebrowsing.phishing.enabled", false);
      user_pref("browser.startup.homepage", "https://bossearch.github.io/tab/");
      user_pref("browser.startup.page", 3);
      user_pref("browser.tabs.hoverPreview.enabled", false);
      user_pref("browser.tabs.hoverPreview.showThumbnails", false);
      user_pref("browser.toolbars.bookmarks.visibility", "never");
      user_pref("browser.urlbar.placeholderName", "DuckDuckGo");
      user_pref("browser.urlbar.placeholderName.private", "DuckDuckGo");
      user_pref("browser.urlbar.shortcuts.bookmarks", false);
      user_pref("browser.urlbar.shortcuts.history", false);
      user_pref("browser.urlbar.shortcuts.tabs", false);
      user_pref("browser.urlbar.suggest.engines", false);
      user_pref("browser.urlbar.suggest.searches", false);
      user_pref("browser.urlbar.suggest.topsites", false);
      user_pref("browser.warnOnQuitShortcut", false);
      user_pref("dom.security.https_only_mode", true);
      user_pref("dom.security.https_only_mode_ever_enabled", true);
      user_pref("layout.css.prefers-color-scheme.content-override", 0);
      user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
      user_pref("network.cookie.cookieBehavior.optInPartitioning", true);
      user_pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
      user_pref("privacy.annotate_channels.strict_list.enabled", true);
      user_pref("privacy.donottrackheader.enabled", true);
      user_pref("privacy.fingerprintingProtection", true);
      user_pref("privacy.globalprivacycontrol.was_ever_enabled", true);
      user_pref("privacy.query_stripping.enabled", true);
      user_pref("privacy.query_stripping.enabled.pbmode", true);
      user_pref("privacy.trackingprotection.emailtracking.enabled", true);
      user_pref("privacy.trackingprotection.enabled", true);
      user_pref("privacy.trackingprotection.socialtracking.enabled", true);
      user_pref("privacy.userContext.enabled", false);
      user_pref("signon.rememberSignons", false);
      user_pref("toolkit.telemetry.cachedClientID", "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0");
      user_pref("toolkit.telemetry.cachedProfileGroupID", "decafdec-afde-cafd-ecaf-decafdecafde");

      user_pref("datareporting.usage.uploadEnabled", false);
      user_pref("extensions.formautofill.addresses.enabled", false);
      user_pref("extensions.formautofill.creditCards.enabled", false);
      user_pref("network.trr.mode", 5);

      user_pref("browser.newtabpage.activity-stream.showSponsored", false); // [FF58+] Pocket > Sponsored Stories
      user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false); // [FF83+] Sponsored shortcuts
      user_pref("browser.newtabpage.activity-stream.default.sites", "");
      user_pref("browser.ping-centre.telemetry", false);
      user_pref("browser.vpn_promo.enabled", false);
      user_pref("media.webspeech.synth.dont_notify_on_error", true);
      user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
      user_pref("toolkit.telemetry.shutdownPingSender.enabledFirstsession", false);
      user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
      user_pref("geo.provider.use_corelocation", false); // [MAC]
      user_pref("geo.provider.use_gpsd", false); // [LINUX]
      user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]
      user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
      user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

      /****************************************************************************
       * SECTION: SMOOTHFOX                                                       *
      ****************************************************************************/
      // visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
      // Enter your scrolling overrides below this line:
      user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
      user_pref("general.smoothScroll", true); // DEFAULT
      user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
      user_pref("general.smoothScroll.msdPhysics.enabled", true);
      user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
      user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
      user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
      user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
      user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
      user_pref("general.smoothScroll.currentVelocityWeighting", "1");
      user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
      user_pref("mousewheel.default.delta_multiplier_y", 250); // 250-400; adjust this number to your liking

      /****************************************************************************
       * END: BETTERFOX                                                           *
      ****************************************************************************/
    '';
  };
}
