{pkgs, ...}: {
  # System configuration
  system = {
    # Set primary user (required for homebrew and dock settings)
    primaryUser = "emonti";
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
  nix.enable = false;
  #nix.optimise.automatic = true;
  nixpkgs.config.allowUnfree = true;

  # User reference - not creating the user, just referencing the existing one
  users.users.emonti = {
    name = "emonti";
    home = "/Users/emonti";
  };

  environment.systemPackages = with pkgs; [
    fish
  ];
  programs.fish.enable = true;

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
      "claude"
      "bruno"
    ];
  };
}
