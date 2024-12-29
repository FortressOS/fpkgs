{
  nixpkgsFor,
  system,
  fortify,
}:

let
  buildPackage = fortify.buildPackage.${system};
  callFortifyPackage = path: nixpkgsFor.${system}.callPackage path { inherit buildPackage; };
in

{
}
