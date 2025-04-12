{ pkgs, ... }: {
  home.username = "emonti";
  home.homeDirectory = "/Users/emonti";
  home.stateVersion = "24.11"; # Use appropriate version
  home.packages = with pkgs; [
    # Nix Language Server
    nixd
    # Utilities
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
    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        format = '' "
          $username\
          $hostname\
          $directory\
          $git_branch\
          $git_state\
          $git_status\
          $cmd_duration\
          $line_break\
          $python\
          $golang\
          $nodejs\
          $nix_shell\
          $direnv\
          $container\
          $character" '';

        directory = {
          style = "blue";
        };

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };

        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };

        git_status = {
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };

        git_state = {
          format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          style = "bright-black";
        };

        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };

        python = {
          format = "[$virtualenv]($style) ";
          style = "bright-black";
        };
      };
    };
    zed-editor = {
      enable = true;
      extensions = [
        "tokyo-night"
        "nix"
        "html"
        "xml"
        "mermaid"
        "workflow-description-language"
        "markdown-oxide"
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
        languages = {
          markdown = {
            format_on_save = "on";
          };
        };
        base_keymap = "VSCode";
        ui_font_size = 16;
        buffer_font_size = 16;
        theme = {
          mode = "system";
          light = "Gruvbox Light Soft";
          dark = "Tokyo Night";
        };
      };
      userKeymaps = { };
      installRemoteServer = false;
    };
  };

}
