{ config, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "damhiya";
      user.email = "damhiya@gmail.com";
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      init.defaultBranch = "main";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
    };
  };
}
