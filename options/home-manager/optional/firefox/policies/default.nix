{homes, ...}: {
  BlockAboutProfiles = true;
  DisableFeedbackCommands = true;
  DisableFirefoxAccounts = true;
  DisableFirefoxStudies = true;
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
  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  PopupBlocking.Default = true;
  Preferences = import ./preferences.nix;
  Cookies = {
    Allow = homes.firefox.allowlist;
    Behavior = "reject-tracker";
    BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
    Locked = true;
  };
  ExtensionSettings = import ./extension.nix;
  "3rdparty".Extensions = import ./extension-settings.nix;
}
