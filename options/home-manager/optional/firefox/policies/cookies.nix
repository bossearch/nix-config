{hosts, ...}: let
  allowlist.cookies =
    if hosts.hostname == "silvia"
    then [] ++ (import ./allowlist.nix).cookies
    else [];
in {
  Allow = allowlist.cookies;
  Behavior = "reject-tracker";
  BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
  Locked = true;
}
