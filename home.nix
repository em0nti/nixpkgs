{ pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "emonti";
  home.homeDirectory = "/Users/emonti";

  # Start with a minimal set of packages
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

  # Begin with minimal program configurations
  programs = {
    # Enable Home Manager itself
    home-manager.enable = true;

    # Start with a simple program configuration, like direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # You can gradually add more program configurations later
  };

  # State version - don't change this
  home.stateVersion = "24.11"; # Use appropriate version
}
