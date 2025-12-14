# NixOS configuration for making documents, presentations and books

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      asciidoctor  # A faster Asciidoc processor written in Ruby
      kdePackages.okular # KDE document viewer (can sign PDFs: https://askubuntu.com/a/1514769)
      libreoffice  # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
      open-pdf-sign  # Digitally sign PDF files from your commandline
      pandoc  # Converter between documentation formats
      pdf-sign  # Tool to visually sign PDF files
      poppler-utils  # PDF rendering library
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
