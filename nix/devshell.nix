{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  config.perSystem = {
    pkgs,
    config,
    ...
  }: {
    config.devshells.default = let
      go = pkgs.go_1_20;
    in {
      motd = "";
      env = [
        {
          name = "GOROOT";
          value = go + "/share/go";
        }
        {
          name = "LD_LIBRARY_PATH";
          value = "$DEVSHELL_DIR/lib";
        }
      ];

      devshell.startup = {
        export-devshell-env.text = ''
          rm -f "$PRJ_ROOT/nix/env"
          ln -s "$DEVSHELL_DIR" "$PRJ_ROOT/nix/env"
        '';
      };

      packages = with pkgs; [
        go
        go-tools
        delve
      ];
    };
  };
}
