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
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };

    # NSGlobalDomain."com.apple.trackpad.scaling" = 2;
    controlcenter.BatteryShowPercentage = true;
    loginwindow.GuestEnabled = false;

    NSGlobalDomain = {
      "com.apple.swipescrolldirection" = true;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleMeasurementUnits = "Centimeters";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "Always";
      NSDisableAutomaticTermination = false;
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  };

  # Necessary for using flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 6;
}
