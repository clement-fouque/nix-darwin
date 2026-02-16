{ pkgs, ... }:

{
  # Professional MacBook specific configuration

  system.primaryUser = "clementfouque";
  
  # Work-specific packages
  environment.systemPackages = with pkgs; [
    # Add work tools here
    # Example: docker, kubernetes tools, work-specific IDEs

    vscode-extensions.pkief.material-icon-theme
    vscode-extensions.ms-vscode-remote.remote-containers
    vscode-extensions.ms-python-python
    vscode-extensions.github.vscode-pull-request-github
    vscode-extensions.github.vscode-github-actions
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
      "docker"
      "gemini-cli"
      "gh"
      "keybase"
      "lastpass"
    ];
  };

  # Work-specific settings
  # system.defaults.dock.tilesize = 36;

  # Host platform
  nixpkgs.hostPlatform = "aarch64-darwin";
}
