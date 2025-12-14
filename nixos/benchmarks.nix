# NixOS configuration for various benchmarks (software and hardware)

{ config, lib, pkgs, ... }: {

  imports = [
    ./common.nix  # Common configuration shared by all of our NixOS systems
  ];

  environment = {
    systemPackages = with pkgs; [
      fbmark  # Linux framebuffer benchmarking tool
      geekbench  # CPU benchmarking tool
      glmark2  # OpenGL benchmarking tool (with Wayland support)
      libdrm  # Direct Rendering library and test utilities (e.g. modetest)
      mesa-demos  # Collection of demos and test programs for OpenGL and Mesa
      vkmark  # Vulkan benchmarking suite
      vulkan-tools  # Khronos official Vulkan Tools and Utilities
    ] ++ [
      # Experimental packages (a separate list to make it easier to exclude from commits)
    ];
  };
}
