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
  blockaboutprofiles = true;
  disablefeedbackcommands = true;
  disablefirefoxaccounts = false;
  disablefirefoxstudies = true;
  disablesetdesktopbackground = true;
  disabletelemetry = true;
  displaybookmarkstoolbar = "never";
  enabletrackingprotection = {
    value = true;
    locked = true;
    cryptomining = true;
    fingerprinting = true;
    emailtracking = true;
  };
  nodefaultbookmarks = true;
  offertosavelogins = false;
  passwordmanagerenabled = false;
  popupblocking.default = true;
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
  Preferences = import ./preferences.nix;
  Cookies = {
    Allow = allowlist.cookies;
    Behavior = "reject-tracker";
    BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
    Locked = true;
  };
  ExtensionSettings = import ./extension.nix;
  "3rdparty".Extensions = import ./extension-settings.nix;
}
