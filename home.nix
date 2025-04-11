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
    command = ${pkgs.fish}/bin/fish --login --interactive
    shell-integration = fish
    font-size = 16
  '';

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        # Add Homebrew to PATH
        if test -d /opt/homebrew/bin
          fish_add_path /opt/homebrew/bin
          fish_add_path /opt/homebrew/sbin
        else if test -d /usr/local/bin
          fish_add_path /usr/local/bin
          fish_add_path /usr/local/sbin
        end

        # Set Homebrew environment variables
        set -gx HOMEBREW_PREFIX "/opt/homebrew"
        set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
        set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
      '';
    };
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "html"
        "xml"
        "mermaid"
        "workflow-description-language"
      ];
      userSettings = {
        features = {
          edit_prediction_provider = "copilot";
        };
        assistant = {
          default_model = {
            provider = "zed.dev";
            model = "claude-3-7-sonnet-latest";
          };
          version = "2";
        };
        base_keymap = "VSCode";
        ui_font_size = 16;
        buffer_font_size = 16;
        theme = {
          mode = "system";
          light = "Tokyo Night Light";
          dark = "Tokyo Night";
        };
      };
      userKeymaps = { };
      installRemoteServer = false;
    };
  };

  # State version - don't change this
  home.stateVersion = "24.11"; # Use appropriate version
}
