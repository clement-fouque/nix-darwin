{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  programs.zsh.enable = true;

  programs.zsh.initContent = ''
    elastic-package-serverless-qa() {
      ELASTIC_PACKAGE_SERVERLESS_KIBANA_SKIP_UPLOAD_PACKAGE_VALIDATION=true command elastic-package "$@"
    }
  '';

  # Written to ~/.zshenv (read by every zsh, including non-interactive ones).
  # The secret file is user-managed and never enters the repo or the nix store.
  # set -a exports every assignment, so plain KEY=value lines reach child processes.
  programs.zsh.envExtra = ''
    if [ -f "$HOME/.elastic-package/serverless.env" ]; then
      set -a
      source "$HOME/.elastic-package/serverless.env"
      set +a
    fi
  '';

  # Create a private placeholder with the variable name once; never overwrite an existing file.
  home.activation.createServerlessEnv = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="$HOME/.elastic-package/serverless.env"
    if [ ! -e "$target" ]; then
      run mkdir -p "$HOME/.elastic-package"
      if [ -z "''${DRY_RUN:-}" ]; then
        (umask 077 && echo 'export EC_API_KEY=' > "$target")
      fi
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
