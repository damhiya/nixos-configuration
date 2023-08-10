{
  # Note that TLP does not conflict with thermald
  # https://linrunner.de/tlp/faq/installation.html#does-tlp-conflict-with-other-power-management-tools
  services.thermald.enable = true;
  services.tlp.enable = true;
}
