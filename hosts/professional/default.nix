{ pkgs, ... }:

{
  # Professional MacBook specific configuration
  
  # Work-specific packages
  environment.systemPackages = with pkgs; [
    # Add work tools here
    # Example: docker, kubernetes tools, work-specific IDEs
  ];

  # Work-specific settings
  # system.defaults.dock.tilesize = 36;

  # Host platform
  nixpkgs.hostPlatform = "x86_64-darwin";
}
