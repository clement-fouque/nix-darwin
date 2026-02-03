{ pkgs, ... }:

{
  # Shared packages across all hosts
  environment.systemPackages = with pkgs; [
    jq
    git
  ];

  # Configure sudo with Touch ID
  # security.pam.enableSudoTouchIdAuth = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  # Additional shared macOS defaults
  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
    };
    
  };

  # https://nix-darwin.github.io/nix-darwin/manual/
  system.defaults = {
    NSGlobalDomain.NSDisableAutomaticTermination = false;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleShowScrollBars = "Always";
    NSGlobalDomain."com.apple.swipescrolldirection" = true;
    # NSGlobalDomain."com.apple.trackpad.scaling" = 2;
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    controlcenter.BatteryShowPercentage = true;
  };

  # Necessary for using flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 6;
}
