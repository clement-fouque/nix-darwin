{ pkgs, username, ... }:

{
  # Professional MacBook specific configuration

  system.primaryUser = username;
  
  # Work-specific packages
  environment.systemPackages = with pkgs; [
    gemini-cli
    gh
    go
    # vscode-extensions.pkief.material-icon-theme
    # vscode-extensions.ms-vscode-remote.remote-containers
    # vscode-extensions.ms-python.python
    # vscode-extensions.github.vscode-pull-request-github
    # vscode-extensions.github.vscode-github-actions
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
