-- customize mason plugins

local utils = require "astronvim.utils"

return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "tsserver", "eslint" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("eslint_fix_creator", { clear = true }),
        desc = "Create autocommand in buffers where eslint attaches",
        callback = function(args)
          if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePost", {
              desc = "Fix all eslint errors",
              buffer = args.buf,
              group = vim.api.nvim_create_augroup(("eslint_fix_%d"):format(args.buf), { clear = true }),
              callback = function()
                if vim.fn.exists ":EslintFixAll" > 0 then vim.cmd.EslintFixAll() end
              end,
            })
          end
        end,
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        "prettierd",
        "eslint-lsp",
        "stylua",
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
        -- "python",
      })
    end,
  },
}
