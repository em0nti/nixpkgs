{ pkgs, ... }: {
  home.username = "emonti";
  home.homeDirectory = "/Users/emonti";
  home.packages = with pkgs; [
    # Add a few user-level packages as a test
    bat
    eza
    fabric-ai
  ];

  # Careful with environment variables - start with a minimal set
  home.sessionVariables = {
    # Only add variables that won't conflict with existing ones
    # NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };

  # Configure Ghostty to use Fish as the default shell
  xdg.configFile."ghostty/config".text = ''
    shell = ${pkgs.fish}/bin/fish
    font-family = "Hack Nerd Font"
    font-size = 14
'';

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish = {
      enable = true;
    };  

  };

  # State version - don't change this
  home.stateVersion = "24.11"; # Use appropriate version
}
