{hosts, ...}: {
  AIControls = import ./aicontrols.nix;
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  "3rdparty".Extensions = import ./extension-settings.nix;
  BlockAboutProfiles = true;
  Cookies = import ./cookies.nix {inherit hosts;};
  DisableAppUpdate = true;
  DisableFeedbackCommands = true;
  DisableFirefoxAccounts = false;
  DisableFirefoxScreenshots = false;
  DisableFirefoxStudies = true;
  DisableMasterPasswordCreation = true;
  DisableSetDesktopBackground = true;
  DisableTelemetry = true;
  DisplayBookmarksToolbar = "never";
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Cryptomining = true;
    Fingerprinting = true;
    EmailTracking = true;
  };
  ExtensionSettings = import ./extension.nix;
  ExtensionUpdate = true;
  HardwareAcceleration = true;
  Homepage = {
    URL = "https://bossearch.github.io/tab/";
    Locked = true;
    StartPage = "previous-session";
  };
  HttpAllowlist = [];
  HttpsOnlyMode = "force_enabled";
  InstallAddonsPermission.Default = true;
  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  Permissions = import ./permissions.nix {inherit hosts;};
  PictureInPicture.Enabled = false;
  PopupBlocking.Default = true;
  Preferences = import ./preferences.nix;
  PrintingEnabled = true;
  SanitizeOnShutdown = {
    Cache = true;
    Cookies = false;
    FormData = true;
    History = false;
    Sessions = false;
    SiteSettings = false;
    Locked = true;
  };
  SearchEngines = {
    PreventInstalls = true;
    Remove = ["Perplexity" "perplexity"];
  };
  SearchSuggestEnabled = false;
  # WebsiteFilter = {
  #   Block = ["<all_urls>"];
  #   Exceptions = ["http://example.org/*"];
  # };
}
