{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # llvm
    llvm_14
    clang_14
    lldb_14

    # gnu
    gcc12
    gfortran12
    gdb
    binutils
  ];
}
