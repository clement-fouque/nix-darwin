{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  home.sessionPath = [
    "$HOME/go/bin"
  ];

  home.activation.installGoPackages = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="/opt/homebrew/bin:$PATH"
    ${builtins.concatStringsSep "\n" (map (pkg: ''
      run go install ${pkg}
    '') [
      "github.com/elastic/elastic-package@latest"
    ])}
  '';
}
