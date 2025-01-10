{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.omakix;
in {
  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        general.import = [
          ./assets/themes/alacritty/${cfg.theme}.toml
          ./assets/fonts/alacritty/${cfg.font}.toml
        ];
        font.size =
          if cfg.doubleScale
          then 9
          else 14;
        env.TERM = "xterm-256color";
        shell.program = "${pkgs.zellij}/bin/zellij";
        window = {
          padding.x = 16;
          padding.y = 14;
          decorations = "None";
          opacity = 0.97;
        };
        keyboard = {
          bindings = [
            {
              key = "F11";
              action = "ToggleFullscreen";
            }
          ];
        };
      };
    };
  };
}
