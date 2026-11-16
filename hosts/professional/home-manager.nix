{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  programs.zsh.enable = true;

  # Written to ~/.zshenv (read by every zsh, including non-interactive ones).
  # The secret file is user-managed and never enters the repo or the nix store.
  programs.zsh.envExtra = ''
    [ -f "$HOME/.elastic-package/serverless.env" ] && source "$HOME/.elastic-package/serverless.env"
  '';

  # Create an empty private placeholder once; never overwrite an existing file.
  home.activation.createServerlessEnv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="$HOME/.elastic-package/serverless.env"
    if [ ! -e "$target" ]; then
      run mkdir -p "$HOME/.elastic-package"
      (umask 077 && run touch "$target")
    fi
  '';

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
