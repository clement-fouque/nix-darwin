{ pkgs, ... }:

{
  # Personal MacBook specific configuration

  system.primaryUser = "hachou";
  
  # Personal-specific packages
  environment.systemPackages = with pkgs; [
    # Add personal tools here
    # Example: spotify, gaming tools, personal dev tools
    ollama
  ];

  # Personal-specific settings
  # system.defaults.dock.tilesize = 48;

  # Host platform
  nixpkgs.hostPlatform = "x86_64-darwin";
}
