{ pkgs, ... }:

{
  # Personal MacBook specific configuration
  
  # Personal-specific packages
  environment.systemPackages = with pkgs; [
    # Add personal tools here
    # Example: spotify, gaming tools, personal dev tools
  ];

  # Personal-specific settings
  # system.defaults.dock.tilesize = 48;

  # Host platform
  nixpkgs.hostPlatform = "x86_64-darwin";
}
