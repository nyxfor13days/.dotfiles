local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }

    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {
                -- border = "rounded"
            }
        end,
    },
}

return packer.startup(function(use)
    -- Essentials
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"

    -- Themes
    use "projekt0n/github-nvim-theme"
    use "nvim-lualine/lualine.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "akinsho/nvim-bufferline.lua"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-project.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use "jvgrootveld/telescope-zoxide"

    -- Autocomplete
    use "rafamadriz/friendly-snippets"
    use "L3MON4D3/LuaSnip"
    use "hrsh7th/nvim-cmp"
    use {
        "tzachar/cmp-tabnine",
        run="./install.sh",
        requires = "hrsh7th/nvim-cmp"
    }
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "kdheepak/cmp-latex-symbols"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "onsails/lspkind-nvim"
    use "hrsh7th/cmp-cmdline"
    use "windwp/nvim-autopairs"

    -- LSP
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- Documents
    use "iamcco/markdown-preview.nvim"
    use "norcalli/nvim-colorizer.lua"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "numToStr/Comment.nvim"
    use "JoosepAlviste/nvim-ts-context-commentstring"

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
