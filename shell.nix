{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
  nativeBuildInputs = [ stow ];
  shellHook = "exec ./install.sh";
}
