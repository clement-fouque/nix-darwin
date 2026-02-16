{
  description = "Clement Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    # Helper function to create a system configuration
    mkDarwinSystem = hostname: username: nix-darwin.lib.darwinSystem {
      modules = [
        # Shared configuration
        ./modules/shared.nix
        
        # Host-specific configuration
        ./hosts/${hostname}/default.nix
        
        # Home-manager integration
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./hosts/${hostname}/home-manager.nix;
        }
        
        # Set the hostname and configuration revision
        {
          networking.hostName = hostname;
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
  in
  {
    # Personal MacBook configuration
    darwinConfigurations."personal" = mkDarwinSystem "personal" "hachou";

    # Professional MacBook configuration
    darwinConfigurations."professional" = mkDarwinSystem "professional" "clement";
  };
}
