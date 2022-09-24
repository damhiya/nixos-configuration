{ pkgs, ... }: {
  environment.defaultPackages = with pkgs; [ rsync strace curl wget ];
}
