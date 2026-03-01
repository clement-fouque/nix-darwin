{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        email = "clement-fouque@users.noreply.github.com";
        name = "clement-fouque";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
