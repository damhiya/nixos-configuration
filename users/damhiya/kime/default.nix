{ ... }: {
  home.file.kime-config = {
    target = ".config/kime/config.yaml";
    source = ./config.yaml;
  };
}
