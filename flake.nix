{
  description = "My Awesome System Config of Doom";
  outputs = inputs@{ self, nixos-generators, st, nixpkgs, nur, home-manager, ... }:
    let
      selfPkgs = import ./pkgs;
      system = "x86_64-linux";
      user = {
        laptop_double_monitor = "yly_double_monitor";
        laptop_no_nvidia = "yly_no_nvidia";
        laptop_no_nvidia_hyprland = "yly_no_nvidia_hyprland";
        laptop_single_monitor = "yly_single_monitor";

      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          #cudaSupport = true;
          permittedInsecurePackages = [ ];
        };
        overlays = [
          self.overlays.default
          st.overlays.default 
        ] ++ (import ./overlays);
        # ];
      };
      lib = nixpkgs.lib;
    in {
      overlays.default = selfPkgs.overlay;
      nixosConfigurations = {
        laptop_no_nvidia = lib.nixosSystem 
        (builtins.removeAttrs (import ./hosts { inherit system pkgs user inputs self lib; }) ["format"]);
      };
      packages.x86_64-linux.default = nixos-generators.nixosGenerate (import ./hosts { inherit system pkgs user inputs self lib; });
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    st.url = "github:ylyhappy-hello/st";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
