{ pkgs, ... }:

{
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        email = "your.work.email@company.com";  # TODO: Update with your work email
        name = "Your Work Name";  # TODO: Update with your work name
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
