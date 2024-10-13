return {
    {
        "folke/which-key.nvim",
        lazy = false
    }, -- disable a default nvchad plugin


    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            opts = {
                automatic_installation = true,
            },
        },
        config = function()
            require "configs.lspconfig"
        end,
        opts = {
            inlay_hints = {
                enabled = true,
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "python",
                "cpp",
                "latex",
                "markdown",
                "go",
            },
        },
    },

    {
        "rmagatti/auto-session",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",              -- Only needed if you want to use session lens
        },
        bypass_save_filetypes = { "alpha", "dashboard" }, -- or whatever dashboard you use
        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            -- log_level = 'debug',
            auto_restore_last_session = false,
        },
        keys = {
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            { "<leader>sr", "<cmd>SessionSearch<CR>",         desc = "Session search" },
            { "<leader>ss", "<cmd>SessionSave<CR>",           desc = "Save session" },
            { "<leader>sa", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave" },
        },
    },

    {
        "github/copilot.vim",
        lazy = false,
        config = function() -- Mapping tab is already used by NvChad
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            -- The mapping is set to other key, see custom/lua/mappings
            -- or run <leader>ch to see copilot mapping section
            vim.g.copilot_filetypes = {
                cpp = false,
            }
        end,
    },

    {
        "lervag/vimtex",
        lazy = false, -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.

            vim.g.vimtex_view_general_viewer = "/home/mub/.local/bin/SumatraPDF.sh"
            vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            -- vim.g.tex_conceal = "abdmg"
            -- vim.opt.conceallevel = 2
            -- vim.opt.concealcursor = "nc"
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "aux-dir", -- create a directory called aux that will contain all the auxiliary files
                out_dir = "out-dir", -- create a directory called build that will contain all the build files
                -- continuous = 1, -- run the compiler in continuous module
                -- callback = 1, -- run the compiler in callback mode
            }
            vim.g.vimtex_quickfix_ignore_filters = {
                "Underfull",
            }
            -- vim.g.vimtex_quickfix_open_on_warning = 1
        end,
    },

    {
        "ThePrimeagen/vim-be-good",
        lazy = false,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
    },

    {
        "stevearc/aerial.nvim",
        opts = {},
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        keys = {
            { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial: Toggle" },
        },
    },

    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>tx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>tX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>tL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>tQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    {
        "windwp/nvim-ts-autotag",
        -- event = { "BufReadPre", "BufNewFile" },
        -- opts = {
        --     -- Defaults
        --     enable_close = true,           -- Auto close tags
        --     enable_rename = true,          -- Auto rename pairs of tags
        --     enable_close_on_slash = false, -- Auto close on trailing </
        -- },
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
            {
                "luukvbaal/statuscol.nvim",
                config = function()
                    local builtin = require "statuscol.builtin"
                    require("statuscol").setup {
                        relculright = true,
                        segments = {
                            { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
                            { text = { " %s" },                 click = "v:lua.ScSa" },
                            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                        },
                    }
                end,
            },
        },
        event = "BufReadPost",
        opts = {
            open_fold_hl_timeout = 150,
            close_fold_kinds_for_ft = {
                default = { "imports", "comment" },
                json = { "array" },
                c = { "comment", "region" },
            },
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0,
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]",
                },
            },
            fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (" 󰁂 %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end,
        },
        keys = {
            { mode = { "n" }, "zR", "<cmd>lua require('ufo').openAllFolds()<cr>",  desc = "Open all folds" },
            { mode = { "n" }, "zM", "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = "Close all folds" },
            {
                mode = { "n" },
                "zK",
                function()
                    local winId = require("ufo").peekFoldedLinesUnderCursor()
                    if winId then
                        vim.lsp.buf.hover { win = winId }
                    end
                end,
                { desc = "Peek Folding" },
            },
        },
    },

    {
        "nvim-focus/focus.nvim",
        version = "*",
        lazy = false,
        opts = {
            enabled = false,
        },
        config = function()
            vim.keymap.set(
                "n",
                "<leader>ft",
                "<cmd>FocusToggle<CR>",
                { noremap = true, silent = true, desc = "Focus: Toggle" }
            )
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",

        opts = {
            -- add any options here
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true,         -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
            notify = {
                timeout = 1000, -- 1000ms = 1 second
            },

            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
                -- Suppress messages with "line" information after saving
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = [[%".*%".*line]],
                    },
                    opts = { skip = true },
                },
                -- Suppress messages with "L, B" format (e.g., "33L, 3711B")
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = [[%".*%".*%d+L,%s*%d+B]],
                    },
                    opts = { skip = true },
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            {
                "rcarriga/nvim-notify",
                opts = {
                    render = "compact", -- default, compact, minimal, simple
                    timeout = 1000,
                    top_down = false,
                    max_width = 100,
                    background_colour = "#000000",
                },
            },
        },
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup {
                -- config
            }
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
    },

    {
        "echasnovski/mini.icons",
        version = false,
    },

    {
        "sindrets/diffview.nvim",
        event = "BufRead",
    },
    {
        "nvchad/volt",
        lazy = true
    },
    {
        "nvchad/menu",
        lazy = false,
        config = function()
            -- Keyboard users
            vim.keymap.set("n", "<C-m>", function()
                require("menu").open("default")
            end, {})

            -- mouse users + nvimtree users!
            vim.keymap.set("n", "<RightMouse>", function()
                vim.cmd.exec '"normal! \\<RightMouse>"'

                local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
                require("menu").open(options, { mouse = true })
            end, {}) -- config
        end,
    },

    {
        "nvchad/minty",
        cmd = { "Shades", "Huefy" },
    }
}
