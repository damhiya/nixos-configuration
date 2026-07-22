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
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "~/.ssh/id_ed25519";
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
