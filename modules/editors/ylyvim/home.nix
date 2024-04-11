{ config, lib, inputs, user, pkgs, ... }:
let 
  nvim-init = pkgs.writeShellScriptBin "nvim-init" ''
    mkdir -p /home/${user}/.local/jdtls-config
    rm -rf /home/${user}/.local/jdtls-config
    cp ${pkgs.jdt-language-server}/share/config /home/${user}/.local/jdtls-config/ -r
    chmod +w /home/${user}/.local/jdtls-config
  '';
in
{
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        plenary-nvim
        gruvbox-material
        mini-nvim
        telescope-nvim
        leap-nvim
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-nvim-lsp
        cmp-nvim-lua
        luasnip
        cmp_luasnip
        friendly-snippets
        dashboard-nvim
        #null-ls-nvim
        lazy-nvim
        auto-pairs
        #neo-tree-nvim
        nvim-tree-lua
        nvim-web-devicons
        nvim-jdtls
        rust-tools-nvim
        comment-nvim
      ];
    };
  };


home.file.".config/nvim/LICENSE".source = ./vim/LICENSE;
home.file.".config/nvim/lua/user/cmp.lua".source = ./vim/lua/user/cmp.lua;
home.file.".config/nvim/lua/user/nvim-tree.lua".source = ./vim/lua/user/nvim-tree.lua;
home.file.".config/nvim/lua/user/telescope.lua".source = ./vim/lua/user/telescope.lua;
home.file.".config/nvim/lua/user/colorscheme.lua".source = ./vim/lua/user/colorscheme.lua;
home.file.".config/nvim/lua/user/autocommands.lua".source = ./vim/lua/user/autocommands.lua;
home.file.".config/nvim/lua/user/options.lua".source = ./vim/lua/user/options.lua;
home.file.".config/nvim/lua/user/keymaps.lua".source = ./vim/lua/user/keymaps.lua;
home.file.".config/nvim/lua/user/alpha.lua".source = ./vim/lua/user/alpha.lua;
home.file.".config/nvim/lua/user/lsp/null-ls.lua".source = ./vim/lua/user/lsp/null-ls.lua;
home.file.".config/nvim/lua/user/lsp/handlers.lua".source = ./vim/lua/user/lsp/handlers.lua;
home.file.".config/nvim/lua/user/lsp/lspconfig.lua".source = ./vim/lua/user/lsp/lspconfig.lua;
home.file.".config/nvim/lua/user/lsp/init.lua".source = ./vim/lua/user/lsp/init.lua;
home.file.".config/nvim/lua/user/lsp/settings/jdtls.lua".text = import ./vim/lua/user/lsp/settings/jdtls.lua.nix {inherit user pkgs;};
home.file.".config/nvim/lua/user/lsp/settings/clangd.lua".source = ./vim/lua/user/lsp/settings/clangd.lua;
home.file.".config/nvim/lua/user/lsp/settings/lua_ls.lua".source = ./vim/lua/user/lsp/settings/lua_ls.lua;
home.file.".config/nvim/lua/user/lsp/settings/rust_analyzer.lua".source = ./vim/lua/user/lsp/settings/rust_analyzer.lua;
home.file.".config/nvim/lua/user/lsp/settings/gopls.lua".source = ./vim/lua/user/lsp/settings/gopls.lua;
home.file.".config/nvim/lua/user/treesitter.lua".source = ./vim/lua/user/treesitter.lua;
home.file.".config/nvim/README.md".source = ./vim/README.md;
home.file.".config/nvim/init.lua".source = ./vim/init.lua;
home.file.".config/nvim/lombok.jar".source = ./vim/lombok.jar;
home.file.".config/nvim/.gitignore".source = ./vim/.gitignore;

  home.packages = with pkgs; [ 
    nvim-init
    unzip
    fd ripgrep
    #-- LSP --#
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.bash-language-server
    # rnix-lsp
    # nil
    lua-language-server
    gopls
    pyright
    zk
    rust-analyzer
    clang-tools
    # haskell-language-server
    #-- tree-sitter --#
    # tree-sitter
    #-- format --#
    stylua
    black
    nixpkgs-fmt
    rustfmt
    beautysh
    nodePackages.prettier
    # stylish-haskell
    #-- Debug --#
    lldb
  ];
}
