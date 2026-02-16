{ pkgs, ... }:

{
  # Personal MacBook specific configuration

  system.primaryUser = "hachou";
  
  # Personal-specific packages
  environment.systemPackages = with pkgs; [
    ollama

    vscode-extensions.pkief.material-icon-theme
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
      "proton-drive"
      "synology-drive"
      "vmware-fusion"
    ];
  };



  # Personal-specific settings
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Brave Browser.app"
      "/Applications/Spotify.app"
      "/Applications/GitHub Desktop.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/Warp.app"
    ];
  };

  # Host platform
  nixpkgs.hostPlatform = "x86_64-darwin";
}
