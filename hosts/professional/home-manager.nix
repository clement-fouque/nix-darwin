{ pkgs, lib, username, ... }:

{
  home.stateVersion = "24.05";
  home.username = username;
  home.homeDirectory = lib.mkForce "/Users/${username}";
}
