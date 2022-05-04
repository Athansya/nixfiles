{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "atoriz98";
  home.homeDirectory = "/home/atoriz98";

  home.sessionVariables = {
    EDITOR = "vim";  # Predefined editor
  };

  # Packages to install
  home.packages = with pkgs; [
     # pkgs is the set of all packages in the default home.nix implementation

     # Terminal
     tmux # Terminal multiplexer

     # Tools
     bat # Pretty cat replacement
     exa # Better ls written in Rust
     tldr # Simpler manpage with examples
   ];

  # Programs to install and configure in a custom way
  programs = {
     # Fish Shell
     fish = {
       enable = true;

        # Plugins // Look-up info. in NixOS.org + Github
        plugins = [{
          name="foreign-env";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-foreign-env";
            rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
            sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
          };
        }];

        # Shell Aliases
        shellAliases = {
           # Prompt confirmation
           rm = "rm -i";
           cp = "cp -i";
           mv = "mv -i";
           # Enable nested directoriesn
           mkdir = "mkdir -p";
           # Enable fish shell con nix-shell
           nix-shell = "nix-shell --run fish";
         };

        # Custom Functions
        functions = {
          fish_greeting = {
            description = "Starting Greeting";
            body = ""; # Emtpy
          };

          # Fish prompt changes depending on being in nix shell or not
          fish_prompt = {
            description = "Fish prompt";
            body = ''
              set -l nix_shell_info (
                if test -n "$IN_NIX_SHELL"
                  set_color $fish_color_cwd
                  printf '<nix-shell> '
                else
                  set_color $fish_color_cwd
                  printf '%s' $USER

                  set_color normal
                  printf '@%s' $hostname

                  set_color $fish_color_cwd
                  printf '%s' (prompt_pwd)

                  set_color normal
                  printf '%s λ ' (fish_git_prompt)
                end
              )
              echo -n -s "$nix_shell_info"
            '';
          };

          mkdcd = {
            description = "Make a directory and enter it";
            body = "mkdir -p $argv[1]; and cd $argv[1]"; 
          };
        };
      };

     # VIM
     vim = {
       enable = true;
        # Plugins
        plugins = with pkgs.vimPlugins; [
          # Status line
          lightline-vim

          # Theme
          dracula-vim

          # Syntax
          syntastic
          YouCompleteMe

          # FileManager
          nerdtree

          # Git Integration
          vim-gitgutter
          nerdtree-git-plugin
        ]; 
        # Additional configuration
        settings = {
          ignorecase = true;
          relativenumber = true;
          tabstop = 2;
        };

        # vimrc extra configuration
        extraConfig = ''
          set wrap
          set breakindent
          set lineabreak
          set shell=/home/atoriz98/.nix-profile/bin/fish
          colorscheme dracula 
        '';
      };

     # Git
     git = {
       enable = true;
       userName = "Athansya";
       userEmail = "atoriz98@outlook.com";
        # Aliases
        aliases = {
          st = "status"; 
        };
      };
    };


  # TODO

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
