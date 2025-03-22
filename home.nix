{ config, pkgs, ... }:
{
    home.username = "ethan";
    home.homeDirectory = "/home/ethan";

    xdg = {
        enable = true;
        configHome = "/home/ethan/.config";
        dataHome = "/home/ethan/.local/share";
        stateHome = "/home/ethan/.local/state";
        cacheHome = "/home/ethan/.local/cache";
    };

    home.stateVersion = "24.11";

    home.packages = with pkgs; [
    	zsh
        git
        yazi
        tmux
        rustup
        tldr
    ];

    home.file = {
        ".zshrc".source = ../.zshrc; 
        ".config/git".source = ../git;
        ".config/tmux".source = ../tmux;
        ".config/yazi".source = ../yazi;
        # ".config/nvim".source = ../nvim;
    };

    home.sessionVariables = {
        # default editor
        EDITOR = "/usr/bin/nvim";

        # GPG terminal stdin
        GPG_TTY = "$(tty)";

        # apps
        ZINIT_HOME = "$XDG_DATA_HOME/zinit/zinit.git";
    };

    nix = {
      package = pkgs.nixVersions.stable;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    # programs.neovim = {
    #     enable = true;
    #     # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    # };

    programs.home-manager.enable = true;
}
