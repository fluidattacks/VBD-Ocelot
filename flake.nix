{
  description = "BVD-Ocelot: reproducible dev shell to build, test and run the gateway (.NET 8/9/10)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in {
      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          packages = [
            (pkgs.dotnetCorePackages.combinePackages [
              pkgs.dotnetCorePackages."sdk_8_0-bin"
              pkgs.dotnetCorePackages."sdk_9_0-bin"
              pkgs.dotnetCorePackages."sdk_10_0-bin"
            ])
            pkgs.curl
          ];
          shellHook = ''
            export DOTNET_CLI_TELEMETRY_OPTOUT=1
            export DOTNET_NOLOGO=1
            export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
            export DOTNET_ROLL_FORWARD=LatestMajor
          '';
        };
      });
    };
}
