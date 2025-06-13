{
  config,
  pkgs,
  ...
}: let
  automatedusbguard = pkgs.writeScript "automatedusbguard.sh" ''
    #!${pkgs.bash}/bin/bash
    export DISPLAY=:0
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

    DEVICE_PATH="$1"
    LOCKFILE="/tmp/usbguard_lock_$1"  # Use device ID for unique lockfile

    # Prevent duplicate prompts for the same device
    if [ -e "$LOCKFILE" ]; then
      exit 0
    fi

    touch "$LOCKFILE"

    # Get the device name using udevadm
    DEVICE_NAME=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_MODEL=" | cut -d= -f2)
    DEVICE_VENDOR=$(udevadm info --query=property --name="$DEVICE_PATH" | grep -i "ID_VENDOR=" | cut -d= -f2)

    # If the device name is not found, fall back to using the device path
    if [ -z "$DEVICE_NAME" ]; then
      DEVICE_NAME="$DEVICE_PATH"
    fi

    blocked=($(${pkgs.usbguard}/bin/usbguard list-devices | grep block | grep -oP 'id \K[0-9a-f]{4}:[0-9a-f]{4}' | tail -1))

    # Show Zenity dialog
    choice=$(/run/wrappers/bin/su ${config.spec.userName} -c "${pkgs.zenity}/bin/zenity --question \
      --text='Do you trust the $DEVICE_VENDOR $DEVICE_NAME device?' --title='New Device Detected' \
      --ok-label='Allow' --cancel-label='Block'")


    if [ $? -eq 0 ]; then
      ${pkgs.usbguard}/bin/usbguard allow-device $blocked
    else
      :
    fi

    # Clean up after processing
    rm -f "$LOCKFILE"
  '';
in {
  services.udev = {
    enable = true;
    packages = [pkgs.unstable.qmk-udev-rules];
    # mouse, keyboard, hub, monitor hub.
    extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ENV{DEVNAME}!="", \
      ENV{ID_VENDOR_ID}!="4653", ENV{ID_MODEL_ID}!="0001", \
      ENV{ID_VENDOR_ID}!="2109", ENV{ID_MODEL_ID}!="2815", \
      ENV{ID_VENDOR_ID}!="05e3", ENV{ID_MODEL_ID}!="0610", \
      RUN+="${automatedusbguard} $env{DEVNAME}"
    '';
  };
}
