# https://discourse.nixos.org/t/how-to-create-a-script-with-dependencies/7970/2

final: prev:
let
  mkScript =
    name: attrs:
    prev.replaceVarsWith {
      src = ./. + "/${name}.sh";
      replacements = {
        shell = prev.stdenv.shell;
        coreutils = prev.coreutils-full;
      } // attrs;
      dir = "bin";
      isExecutable = true;
      inherit name;
    };
in
{
  scripts = {

    st = mkScript "st" { };

    nixos-profile = mkScript "nixos-profile" { inherit (prev) findutils gawk jq; };

    hyprcwd = mkScript "hyprcwd" { inherit (prev) hyprland jq; };

  };
}
