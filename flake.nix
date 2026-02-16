{
  description = "Clement Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    # Helper function to create a system configuration
    mkDarwinSystem = hostname: nix-darwin.lib.darwinSystem {
      modules = [
        # Shared configuration
        ./modules/shared.nix
        
        # Host-specific configuration
        ./hosts/${hostname}/default.nix
        
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
    darwinConfigurations."personal" = mkDarwinSystem "personal";

    # Professional MacBook configuration
    darwinConfigurations."professional" = mkDarwinSystem "professional";
  };
}
