{ system, self, pkgs, user, lib, inputs, ... }:
let desktop = "x11";
in {
  format = "install-iso";
  inherit system pkgs;
  specialArgs = {
    inherit inputs;
    user = user.laptop_no_nvidia;
  };
  modules = [
    ./laptop_no_nvidia/${desktop}
  ] ++ [ ./system.nix ] ++ [
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { user = user.laptop_no_nvidia; };
        users.${user.laptop_no_nvidia} = {
          imports = [ (import ./laptop_no_nvidia/${desktop}/home.nix) ] ++ [ ];
        };
      };
      nixpkgs = { overlays = [ self.overlays.default ]; };
    }
  ];
}
