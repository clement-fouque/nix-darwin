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

  homebrew = {
    enable = true;
    onActivation = {
      # Be carefull with this option as it'll remove what's not specified
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    brews = [
      
    ];

    casks = [
      "git-credential-manager"
      "raycast"
      "spotify"
      "visual-studio-code"
      "warp"
    ];
  };

  # Personal-specific settings
  # system.defaults.dock.tilesize = 48;

  # Host platform
  nixpkgs.hostPlatform = "x86_64-darwin";
}
