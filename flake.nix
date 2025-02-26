{
  description = "fortify application packages";

  inputs = {
    fortify.url = "git+https://git.gensokyo.uk/security/fortify?ref=fpkg";
  };

  outputs =
    { self, fortify }:
    let
      supportedSystems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
      ];

      inherit (fortify.inputs) nixpkgs;
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (
        system: import ./pkgs/all-packages.nix { inherit nixpkgsFor system fortify; }
      );
    };
}
