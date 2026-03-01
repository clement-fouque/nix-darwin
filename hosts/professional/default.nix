{ pkgs, username, ... }:

{
  # Professional MacBook specific configuration

  system.primaryUser = username;

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
      "gemini-cli"
      "gh"
      "go"
      "lastpass-cli"
    ];

    casks = [
      "bruno"
      "burp-suite"
      "cursor"
      "docker-desktop"
      "google-chrome"
      "keybase"
      "lastpass"
    ];
  };

  # Personal-specific settings
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Brave Browser.app"
      "/Applications/Google Chrome.app"
      "/Applications/Spotify.app"
      "/Applications/GitHub Desktop.app"
      "/Applications/Cursor.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/Warp.app"
    ];
  };

  # Set Google Chrome as default browser
  system.defaults.CustomUserPreferences = {
    "com.apple.LaunchServices/com.apple.launchservices.secure" = {
      LSHandlers = [
        {
          LSHandlerURLScheme = "http";
          LSHandlerRoleAll = "com.google.Chrome";
        }
        {
          LSHandlerURLScheme = "https";
          LSHandlerRoleAll = "com.google.Chrome";
        }
      ];
    };
  };

  # Work-specific settings
  # system.defaults.dock.tilesize = 36;

  # Host platform
  nixpkgs.hostPlatform = "aarch64-darwin";
}
