{
  homes,
  hosts,
  inputs,
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
        user_pref("browser.uiCustomization.horizontalTabsBackup", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"sidebar-button\",\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":4}");
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
      user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"extension_one-tab_com-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"nav-bar\":[\"back-button\",\"forward-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"reset-pbm-toolbar-button\",\"unified-extensions-button\",\"ublock0_raymondhill_net-browser-action\",\"addon_darkreader_org-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"reset-pbm-toolbar-button\",\"developer-button\",\"screenshot-button\",\"_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action\",\"_84c8edb0-65ca-43a5-bc53-0e80f41486e1_-browser-action\",\"ublock0_raymondhill_net-browser-action\",\"extension_one-tab_com-browser-action\",\"addon_darkreader_org-browser-action\",\"sponsorblocker_ajay_app-browser-action\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"unified-extensions-area\",\"TabsToolbar\",\"toolbar-menubar\",\"PersonalToolbar\"],\"currentVersion\":23,\"newElementCount\":4}");
      user_pref("sidebar.main.tools", "syncedtabs,history,bookmarks");
      user_pref("sidebar.position_start", false);
      user_pref("sidebar.visibility", "hide-sidebar");
    '';
in ''
  ${builtins.readFile "${inputs.betterfox}/user.js"}
  user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
  user_pref("devtools.chrome.enabled", true);
  user_pref("devtools.debugger.remote-enabled", true);
  user_pref("devtools.debugger.prompt-connection", false);
  user_pref("mousewheel.default.delta_multiplier_y", 250);
  user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
  user_pref("toolkit.telemetry.shutdownPingSender.enabledFirstsession", false);
  user_pref("webgl.disabled", true);
  ${doh}
  ${sidebar}
''
