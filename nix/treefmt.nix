{inputs, ...}: {
  imports = [
    inputs.flake-root.flakeModule
    inputs.treefmt-nix.flakeModule
  ];
  perSystem = {config, ...}: {
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      flakeCheck = true;
      flakeFormatter = true;
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        gofumpt.enable = true;
        statix.enable = true;
      };
    };
  };
}
