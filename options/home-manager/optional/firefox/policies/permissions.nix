{hosts, ...}: let
  allowlist = let
    list =
      if hosts.hostname == "silvia"
      then import ./allowlist.nix
      else {};
  in {
    notifications = list.notifications or [];
    camera = list.camera or [];
    autoplay = list.autoplay or [];
    microphone = list.microphone or [];
    location = list.location or [];
    screenshare = list.screenshare or [];
  };
in {
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
}
