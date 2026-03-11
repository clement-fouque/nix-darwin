{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  programs.zsh.enable = true;

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.activation.installGoPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="/opt/homebrew/bin:$PATH"
    ${builtins.concatStringsSep "\n" (map (pkg: ''
      run go install ${pkg}
    '') [
      "github.com/elastic/elastic-package@latest"
      "github.com/elastic/mito/cmd/mito@latest"
    ])}
  '';
}
