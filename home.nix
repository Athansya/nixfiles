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
  home.packages = [
     # pkgs is the set of all packages in the default home.nix implementation

     # Terminal
     pkgs.tmux # Terminal multiplexer

     # Editors
     pkgs.vim

     # Tools
     pkgs.bat # Pretty cat replacement
     pkgs.exa # Better ls written in Rust
     pkgs.tldr # Simpler manpage with examples
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
     };
     
     # Git
     git = {
        enable = true;
        userName = "Athansya";
        userEmail = "atoriz98@outlook.com";
     };
  };


  # TODO
  # Configure VIM
  # 

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
