{
  description = "A very basic flake";

  inputs = {
    # Defaults to the nixos-unstable branch
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Stable branch
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      # The follows keyword in inputs is used for inheritance.
      # Here, inputs.nixpkgs of home-manager is kept consistent with
      # the inputs.nixpkgs of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # FIXME replace with your hostname
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          # > Our main nixos configuration file <
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.stoics = {
                  imports = [ ./home.nix ];
                };
              };
            }
          ];
        };
      };
    };
}
