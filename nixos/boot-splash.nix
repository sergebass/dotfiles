# NixOS configuration for boot splash

{ config, lib, pkgs, ... } : {

  boot = {
    # Enable "Silent boot"
    consoleLogLevel = 3;

    initrd = {
      verbose = false;
      systemd.enable = true;  # Start systemd early on, in the initrd stage
    };

    kernelParams = [
      "splash"
      "quiet"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    # Display splash screen during boot, early on.
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        # By default we would install all themes, so be specific instead.
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };
  };
}
