{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
  };
}
