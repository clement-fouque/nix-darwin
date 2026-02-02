{ pkgs, ... }:

{
  # Shared packages across all hosts
  environment.systemPackages = with pkgs; [
    vim
    jq
    git
    curl
    wget
  ];

  # Configure sudo with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  # Auto-hide the menu bar
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

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

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  # Necessary for using flakes
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility
  system.stateVersion = 6;
}
