# NixOS configuration for printers and printing in general.
{ config, lib, pkgs, ... } : {
  hardware = {
    # Uncomment to connect to an explicit printer
    # printers = let
    #   printerHost = "192.168.111.3";
    # in {
    #   ensurePrinters = [
    #     {
    #       name = "Brother-DCP-7060D";
    #       description = "Laser monochrome printer & scanner";
    #       location = "Basement";
    #       deviceUri = "http://${printerHost}:631/printers/DCP-7060D";
    #       model = "drv:///brlaser.drv/br7060d.ppd";
    #       ppdOptions = {
    #         PageSize = "Letter";
    #       };
    #     }
    #   ];
    #   ensureDefaultPrinter = "Brother-DCP-7060D";
    # };
  };

  networking = {
    firewall = {
      enable = true;
      # allowedTCPPorts = [
      #   631  # CUPS
      # ];
      # allowedUDPPorts = [
      #   631  # CUPS
      # ];
    };
  };

  services = {
    system-config-printer.enable = true;

    printing = {
      enable = true;  # Enable CUPS
      startWhenNeeded = true;  # Enable printing on-demand only
      webInterface = true;  # Enable CUPS web UI as well
      browsing = true;  # Advertise local printers on our LAN
      browsed.enable = false;  # But do not browse for external printers (https://www.evilsocket.net/2024/09/26/Attacking-UNIX-systems-via-CUPS-Part-I/)
      listenAddresses = [
        "*:631"
      ];
      allowFrom = [
        "all"
      ];
      openFirewall = true;  # Open ports for listenAddresses
      defaultShared = true;  # Local printers are shared by default.
      cups-pdf.enable = true;  # Enable the virtual PDF printer backend
      drivers = with pkgs; [
        brlaser  # For Brother DCP-7060D (and others)
        # FIXME the last cnijfilter source is version 4.10 (https://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNTg1ODAx&cmp=ABR&lang=EN): blob:https://www.usa.canon.com/a41418e1-7cd4-4000-8bd2-e18dd8eb452b
        cnijfilter_4_00
      ];
    };

    # Enable auto-discovery (of local printers in particular)
    avahi = {
      enable = true;
      openFirewall = true;  # Discovery is done via the opened UDP port 5353
      nssmdns4 = true;  # Enable the mDNS NSS (Name Service Switch) plug-in for IPv4. Enabling it allows applications to resolve names in the .local domain by transparently querying the Avahi daemon.
      nssmdns6 = true;  # Same for IPv6
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      system-config-printer  # Printer configuration/pipeline control UI
    ];
  };
}
