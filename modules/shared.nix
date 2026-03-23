{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Add brew to the path
  environment.variables = {
    PATH = "/opt/homebrew/bin:/opt/homebrew/sbin:$PATH";
  };

  # Shared packages across all hosts
  environment.systemPackages = with pkgs; [
    git
    jq

    vscode-extensions.jnoortheen.nix-ide
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
      "ffmpeg"
      "jq"
    ];

    casks = [
      "brave-browser"
      "git-credential-manager"
      "github"
      "ollama-app"
      "raycast"
      "spotify"
      "superwhisper"
      "visual-studio-code"
      "warp"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Additional shared macOS defaults
  # https://nix-darwin.github.io/nix-darwin/manual/
  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
    };

    finder = {
      _FXSortFoldersFirst = true;
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle  = "clmv";
      NewWindowTarget = "Home";
      ShowExternalHardDrivesOnDesktop = true;
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    # NSGlobalDomain."com.apple.trackpad.scaling" = 2;
    controlcenter.BatteryShowPercentage = true;
    loginwindow.GuestEnabled = false;

    NSGlobalDomain = {
      "com.apple.swipescrolldirection" = false;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "Always";
      NSDisableAutomaticTermination = false;
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    screencapture.target = "preview";

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  };

  # Necessary for using flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 6;
}
