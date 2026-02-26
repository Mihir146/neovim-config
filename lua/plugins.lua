--setup lazy.nvim 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--some plugin functions:
----
---
--
--
--the links are quotes are assumed to be github repos by lazy and 
--so it goes to those github repos to install those themes for you 
require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd.colorscheme("kanagawa-wave")
        end,
    },
    {
        --"EdenEast/nightfox.nvim",
        --config = function()
        --    vim.cmd.colorscheme("duskfox")
        --end, }, {
        --"rose-pine/neovim",
        --config = function()
        --    vim.cmd.colorscheme("rose-pine")
        --end,
    },
    --{
        --"folke/tokyonight.nvim",
        --config = function()                   
        --    vim.cmd.colorscheme("rose-pine")     
        --end,
     --   },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
           require("lualine").setup({
               options = {
               icons_enabled = true,
               theme = 'auto',
               component_separators = { left = '', right = ''},
               section_separators = { left = '', right = ''},
               disabled_filetypes = {
                   statusline = {},
                   winbar = {},
               },
               ignore_focus = {},
               always_divide_middle = true,
               always_show_tabline = true,
               globalstatus = false,
               refresh = {
                   statusline = 100,
                   tabline = 100,
                   winbar = 100,
               }
           },
           sections = {
               lualine_a = {'mode'},
               lualine_b = {'branch', 'diff', 'diagnostics'},
               lualine_c = {{'filename',
                           path = 3,}},
               lualine_x = {'encoding',
               --    {
               --        'diff',
               --        colored = true, -- Displays a colored diff status if set to true
               --        diff_color = {
               --            -- Same color values as the general color option can be used here.
               --            added    = 'LuaLineDiffAdd',    -- Changes the diff's added color
               --            modified = 'LuaLineDiffChange', -- Changes the diff's modified color
               --            removed  = 'LuaLineDiffDelete', -- Changes the diff's removed color you
               --        },
               --        symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
               --        source = nil, -- A function that works as a data source for diff.
               --        -- It must return a table as such:
               --        --   { added = add_count, modified = modified_count, removed = removed_count }
               --        -- or nil on failure. count <= 0 won't be displayed.
               --    },
    --                           {
    --                               'diagnostics',

    --                               -- Table of diagnostic sources, available sources are:
    --                               --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
    --                               -- or a function that returns a table as such:
    --                               --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
    --                               sources = { 'nvim_diagnostic', 'coc' },

    --                               -- Displays diagnostics for the defined severity types
    --                               sections = { 'error', 'warn', 'info', 'hint' },

    --                               diagnostics_color = {
    --                                   -- Same values as the general color option can be used here.
    --                                   error = 'DiagnosticError', -- Changes diagnostics' error color.
    --                                   warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
    --                                   info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
    --                                   hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
    --                               },
    --                               symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
    --                               colored = true,           -- Displays diagnostics status in color if set to true.
    --                               update_in_insert = false, -- Update diagnostics in insert mode.
    --                               always_visible = false,   -- Show diagnostics even if there are none.
    --},
                                   'fileformat', {
                                   'filetype',
                                   colored = true,   -- Displays filetype icon in color if set to true
                                   icon_only = true, -- Display only an icon for filetype
                                   icon = { align = 'right' }, -- Display filetype icon on the right hand side
                                   -- icon =    {'X', align='right'}
                                   -- Icon string ^ in table is ignored in filetype component
                               }
                           },
               lualine_y = {'progress'},
               lualine_z = {'location'}
           },
           inactive_sections = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = {'filename'},
               lualine_x = {'location'},
               lualine_y = {},
               lualine_z = {}
           },
           tabline = {},
           winbar = {},
           inactive_winbar = {},
           extensions = {}
       })
       end,
    },
    {
         "nvim-treesitter/nvim-treesitter",
         config = function()
             require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query","cpp","rust","r","go"},
                auto_install = true,
                highlight ={
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<Leader>ss", -- set to `false` to disable one of the mappings
                        node_incremental = "<Leader>si",
                        scope_incremental = "<Leader>sc",
                        node_decremental = "<Leader>sd",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                }, })
        end,

    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    {
        "nvim-telescope/telescope.nvim", 
        dependencies = { 'nvim-lua/plenary.nvim',
    },
        config = function()
            vim.keymap.set("n", "<Leader>fd",
            require("telescope.builtin").find_files)
        end,
    },
    --this is the older nvim-tree setup, i am using neo-tree now
   -- {
   --     "nvim-tree/nvim-tree.lua",
   --     config = function()
   --         require("nvim-tree").setup({
   --             update_focused_file = {
   --                 enable = true,
   --                 update_root = true,
   --             },
   --             sort = {
   --                 sorter = "case_sensitive",
   --             },
   --             view = {
   --                 width = 30,
   --             },
   --             renderer = {
   --                 group_empty = true,
   --             },
   --             filters = {
   --                 dotfiles = true,
   --             },
   --         })

   --         vim.keymap.set("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>")
   --     end,
   -- },
   --
   -- this is the neo-tree config
   {
       "nvim-neo-tree/neo-tree.nvim",
       branch = "v3.x",
       dependencies = {
           "nvim-lua/plenary.nvim",
           "nvim-tree/nvim-web-devicons",
           "MunifTanjim/nui.nvim",
       },
       config = function()
           require("neo-tree").setup({
               close_if_last_window = true,
               popup_border_style = "rounded",
               enable_git_status = true,
               enable_diagnostics = true,

               window = {
                   position = "left",
                   width = 30,
               },

               filesystem = {
                   follow_current_file = {
                       enabled = true,
                   },
                   hijack_netrw_behavior = "open_default",
               },

               default_component_configs = {
                   git_status = {
                       symbols = {
                           added     = "✚",
                           modified  = "",
                           deleted   = "✖",
                           renamed   = "󰁕",
                           untracked = "",
                           ignored   = "",
                           unstaged  = "󰄱",
                           staged    = "",
                           conflict  = "",
                       },
                   },
               },
           })

           -- Keymaps
           vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
           vim.keymap.set("n", "<Leader>bf", "<cmd>Neotree buffers<CR>", { desc = "Neo-tree buffers" })
           vim.keymap.set("n", "<Leader>gs", "<cmd>Neotree git_status<CR>", { desc = "Neo-tree git status" })
       end,
   },
    -- Mason core
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason ↔ LSP bridge (auto install)
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "pyright",
                    "lua_ls",
                    "rust_analyzer",
                    "gopls",
                },
                automatic_installation = true,
            })
        end,
    },

    -- LSP config (NEW Neovim 0.11 API)
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            local servers = {
                clangd = {},
                pyright = {},
                rust_analyzer = {},
                gopls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
            }

            for name, conf in pairs(servers) do
                conf.capabilities = capabilities
                vim.lsp.config(name, conf)
            end
        end,
    },

       --completion engine (blink.cmp)
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

   })
