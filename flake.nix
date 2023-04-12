{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    spicetify-nix.url = "github:the-argus/spicetify-nix";

  };
  outputs = {nixos-hardware, nixpkgs, nur, hyprland, home-manager, spicetify-nix, ... }@inputs: {

    nixosConfigurations.zephyr = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
      ./configuration.nix
      hyprland.nixosModules.default
      home-manager.nixosModules.home-manager
      nur.nixosModules.nur
      {
	home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs;};
	home-manager.users.curiouslad.imports = [
	  modules/home-manager/home.nix
          hyprland.homeManagerModules.default
          spicetify-nix.homeManagerModule
          ./modules/config.nix

        ];
        nixpkgs.overlays = [ nur.overlay ];
      }
      nixos-hardware.nixosModules.asus-zephyrus-ga401
    ];
    };
  };
}
