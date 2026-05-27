{hosts, ...}: let
  allowlist = let
    list =
      if hosts.hostname == "silvia"
      then import ./allowlist.nix
      else {};
  in {
    cookies = list.cookies or [];
    notifications = list.notifications or [];
    camera = list.camera or [];
    autoplay = list.autoplay or [];
    microphone = list.microphone or [];
    location = list.location or [];
    screenshare = list.screenshare or [];
  };
in {
  "3rdparty".Extensions = import ./extension-settings.nix;
  BlockAboutProfiles = true;
  Cookies = {
    Allow = allowlist.cookies;
    Behavior = "reject-tracker";
    BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
    Locked = true;
  };
  DisableFeedbackCommands = true;
  DisableFirefoxAccounts = false;
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
  ExtensionSettings = import ./extension.nix;
  NoDefaultBookmarks = true;
  OfferToSaveLogins = false;
  PasswordManagerEnabled = false;
  Permissions = {
    Camera = {
      Allow = allowlist.camera;
      BlockNewRequests = true;
      Locked = true;
    };
    Microphone = {
      Allow = allowlist.microphone;
      BlockNewRequests = true;
      Locked = true;
    };
    Location = {
      Allow = allowlist.location;
      BlockNewRequests = true;
      Locked = true;
    };
    Notifications = {
      Allow = allowlist.notifications;
      BlockNewRequests = true;
      Locked = true;
    };
    Autoplay = {
      Allow = allowlist.autoplay;
      Default = "block-audio";
      Locked = true;
    };
    ScreenShare = {
      Allow = allowlist.screenshare;
      BlockNewRequests = true;
      Locked = true;
    };
    VirtualReality = {
      BlockNewRequests = true;
      Locked = true;
    };
  };
  PopupBlocking.Default = true;
  Preferences = import ./preferences.nix;
}
