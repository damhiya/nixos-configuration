{ config, ... }:
{
  programs.git = {
    enable = true;
    userName = "damhiya";
    userEmail = "damhiya@gmail.com";
    delta.enable = true;
    delta.options = {
      navigate = true;
      line-numbers = true;
    };
    extraConfig = {
      diff = {
        colorMoved = "default";
      };
      merge = {
        conflictstyle = "diff3";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
