{ inputs, pkgs, ... }:
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
        rustup
        tldr
    ];

    home.file = {
        ".zshrc".source = ~/repos/dotfiles/.zshrc;
        ".config/git".source = ~/repos/dotfiles/git;
        ".config/tmux".source = ~/repos/dotfiles/tmux;
        ".config/nvim".source = ~/repos/dotfiles/nvim;
        ".config/yazi".source = ~/repos/dotfiles/yazi;
        ".config/home-manager".source = ~/repos/dotfiles/home-manager;

        ".config/neovim".source = ~/repos/neovim;
    };

    home.sessionVariables = {
        # default editor
        EDITOR = "/usr/bin/nvim";

        # GPG terminal stdin
        GPG_TTY = "$(tty)";

        # apps
        ZINIT_HOME = "$XDG_DATA_HOME/zinit/zinit.git";
    };

    programs.git.enable = true;
    programs.neovim = {
        enable = true;
        # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    programs.zsh.enable = true;
    programs.yazi.enable = true;
    programs.tmux.enable = true;
    programs.home-manager.enable = true;
}
