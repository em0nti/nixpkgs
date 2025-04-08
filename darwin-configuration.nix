{ pkgs, ... }: {
  # Minimal system defaults - add only what you want to manage
  system.defaults = {
    dock = {
      # Example: Only manage specific dock settings
      autohide = true;
    };
  };

  # Nix configuration
  # The Determinate Systems installer likely already set these up,
  # but it's good to make them explicit in your configuration
  # Enable Nix
  nix.enable = false;
  # Use the new optimise option
  #nix.optimise.automatic = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User reference - not creating the user, just referencing the existing one
  users.users.emonti = {
    name = "emonti";
    home = "/Users/emonti";
  };

  # Start with a minimal set of packages you want to be managed by nix-darwin
  # These might be new tools or replacements for ones you're migrating from Homebrew
  environment.systemPackages = with pkgs; [
    # Utilities
    htop
    tree
  ];

  # Homebrew integration - this allows nix-darwin to be aware of Homebrew
  # but doesn't necessarily manage it fully yet
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    # Start with 'uncleanable' which doesn't remove any existing Homebrew packages
    onActivation.cleanup = "none";

    # You can optionally start listing some Homebrew packages you want to ensure are installed
    # but this is not required for initial setup
    brews = [
      # Example: "wget"
      "fish"
    ];
    casks = [
      "marta"
      "raycast"
      "ukrainian-typographic-keyboard"
      "font-hack-nerd-font"
    ];
  };

  # Used for backwards compatibility
  system.stateVersion = 4;
}
