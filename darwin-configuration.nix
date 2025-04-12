{ pkgs, ... }: {
  # System configuration
  system = {
    # System defaults
    defaults = {
      dock = {
        autohide = true;
        #show-recents = false;  # Hide recent applications
        #mru-spaces = false;    # Don't automatically rearrange spaces
        #orientation = "bottom";
      };
    };

    # Set default shell to Fish more safely using activation script
    activationScripts.postActivation.text = ''
      if [ "$SHELL" != "${pkgs.fish}/bin/fish" ]; then
        sudo chsh -s ${pkgs.fish}/bin/fish emonti
      fi
    '';

    # Used for backwards compatibility
    stateVersion = 4;
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
    shell = pkgs.fish;
  };

  environment = {
    systemPackages = with pkgs; [
    # Utilities
    git
    fish
    htop
    tree
    devenv # https://devenv.sh/
  ];

  # Shell configuration
  shells = [ pkgs.fish ];
  };

  # Homebrew integration - this allows nix-darwin to be aware of Homebrew
  # but doesn't necessarily manage it fully yet
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "uninstall";
    brews = [
      # Example: "wget"
    ];
    casks = [
      "marta"
      "raycast"
      "ukrainian-typographic-keyboard"
      "font-hack-nerd-font"
      "ghostty"
      "zed"
    ];
  };

  programs.fish = {
    enable = true;
  };
}
