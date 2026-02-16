{ pkgs, lib, ... }:

{
  home.stateVersion = "24.05";
  home.username = "hachou";
  home.homeDirectory = lib.mkForce "/Users/hachou";

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
