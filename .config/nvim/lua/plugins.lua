return require('packer').startup(function(use, use_rocks)
    -- Packer can manager itself
    use 'wbthomason/packer.nvim'

    -- indent blankline
    use 'lukas-reineke/indent-blankline.nvim'

    -- telescope search
    use{
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- nvim-tree file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- bufferline tab
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use({
        'ckolkey/ts-node-action',
        requires = { 'nvim-treesitter' },
        config = function()
            require("ts-node-action").setup({})
        end
    })

    -- lsp
    use 'neovim/nvim-lspconfig'

      -- autocompletion
    use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
    use 'hrsh7th/cmp-buffer'   -- { name = 'buffer' },
    use 'hrsh7th/cmp-path'     -- { name = 'path' }
    use 'hrsh7th/cmp-cmdline'  -- { name = 'cmdline' }
    use 'lukas-reineke/cmp-under-comparator' -- sort options
    use{'hrsh7th/nvim-cmp', requires = 'rafamadriz/friendly-snippets'}

    -- luasnip auto completion snippet
    use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
    use'saadparwaiz1/cmp_luasnip'

    -- lspkind pictogram to lsp
    use 'onsails/lspkind-nvim'

    -- symbols outline
    use 'simrat39/symbols-outline.nvim'

    -- comment
    use 'terrortylor/nvim-comment' -- gc gcc

    -- signature
    use "ray-x/lsp_signature.nvim"

    -- everforest theme
    use "sainnhe/everforest"

    -- kanagawa theme
    use 'rebelot/kanagawa.nvim'

    -- manson manages lsp
    use "williamboman/mason.nvim"

    -- alpha dashboard
    use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'plugin-config.alpha'.config)
    end
    }

    -- nvim-colorizer colorize color code
    use 'norcalli/nvim-colorizer.lua'

    -- project.nvim change cwd
    use "ahmedkhalf/project.nvim"

    -- toggleterm terminal
    use "akinsho/toggleterm.nvim"

    -- impatient speedup startup
    use "lewis6991/impatient.nvim"

    -- pairs up parenthesis
    use "windwp/nvim-autopairs"
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- close = "<A-b>",
                -- open_vsplit = { "<A-b>" }
            }
        end
    }

    -- better rename
    use {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Cargo.toml crates
    use {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('crates').setup()
        end,
    }

    use "j-hui/fidget.nvim"
    use "simrat39/rust-tools.nvim"
    use 'mfussenegger/nvim-dap'

    use "RaafatTurki/hex.nvim"

    -- [[ LUAROCK MODULES ]]

    use_rocks 'luafilesystem'
end)
