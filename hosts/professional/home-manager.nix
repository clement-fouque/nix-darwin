{ pkgs, lib, ... }:

{
  home.stateVersion = "24.05";
  home.username = "clementfouque";
  home.homeDirectory = lib.mkForce "/Users/clementfouque";
}
