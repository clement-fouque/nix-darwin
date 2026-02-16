{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        email = "alexktz@gmail.com";
        name = "Alex Kretzschmar";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
