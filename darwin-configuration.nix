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
  # but you can override them here if needed
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

  # System packages - these are installed system-wide
  # and are available to all users
  environment.systemPackages = with pkgs; [
    # Utilities
    htop
    tree
    fish
  ];

  # Homebrew integration - this allows nix-darwin to be aware of Homebrew
  # but doesn't necessarily manage it fully yet
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "none";
    brews = [
      # Example: "wget"
    ];
    casks = [
      "marta"
      "raycast"
      "ukrainian-typographic-keyboard"
      "font-hack-nerd-font"
      "ghostty"
    ];
  };

  programs.fish.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 4;
}
