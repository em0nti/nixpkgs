{
  description = "Darwin configuration for an existing Nix system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
  let
    # Determine if you're on Apple Silicon or Intel
    system = "aarch64-darwin"; # Use x86_64-darwin for Intel Macs
    username = "emonti";
    hostname = "emonti-Air.local";
  in {
    darwinConfigurations.${hostname} = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin-configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix;
        }
      ];
    };
  };
}
