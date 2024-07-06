{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # telescope
      ripgrep

      # lua
      lua-language-server
      stylua

      # nix
      nil
      nixd
      alejandra

      # python
      pyright
      ruff
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
    extraLuaConfig = let
      plugins = with pkgs.vimPlugins; [
        LazyVim
        bufferline-nvim
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp_luasnip
        conform-nvim
        dressing-nvim
        dashboard-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        indent-blankline-nvim
        lualine-nvim
        neo-tree-nvim
        neoconf-nvim
        neodev-nvim
        noice-nvim
        nui-nvim
        nvim-cmp
        nvim-lint
        nvim-lspconfig
        nvim-notify
        # nvim-spectre
        nvim-treesitter
        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-ts-autotag
        nvim-ts-context-commentstring
        nvim-web-devicons
        persistence-nvim
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        no-clown-fiesta-nvim
        trouble-nvim
        vim-illuminate
        vim-startuptime
        which-key-nvim
        {
          name = "LuaSnip";
          path = luasnip;
        }
        {
          name = "no-clown-fiesta";
          path = no-clown-fiesta-nvim;
        }
        {
          name = "mini.ai";
          path = mini-nvim;
        }
        {
          name = "mini.bufremove";
          path = mini-nvim;
        }
        {
          name = "mini.comment";
          path = mini-nvim;
        }
        {
          name = "mini.indentscope";
          path = mini-nvim;
        }
        {
          name = "mini.pairs";
          path = mini-nvim;
        }
        {
          name = "mini.surround";
          path = mini-nvim;
        }
      ];
      mkEntryFromDrv = drv:
        if lib.isDerivation drv
        then {
          name = "${lib.getName drv}";
          path = drv;
        }
        else drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in ''
      require("lazy").setup({
        defaults = {
          lazy = true,
        },
        dev = {
          path = "${lazyPath}",
          patterns = {"."},
          fallback = true,
        },
        spec = {
           { "LazyVim/LazyVim", import = "lazyvim.plugins" },
           { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
           { "williamboman/mason-lspconfig.nvim", enabled = false },
           { "williamboman/mason.nvim", enabled = false },
           { import = "plugins" },
           { "nvim-treesitter/nvim-treesitter",
             opts = function(_, opts)
               opts.ensure_installed = {}
             end,
           },
        },
      })
    '';
  };

  xdg.configFile."nvim/parser".source = let
    parsers = pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars)).dependencies;
    };
  in "${parsers}/parser";

  xdg.configFile."nvim/lua".source = ./lua;
}
