-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    ["<leader>sv"] = {
      "<cmd>vsplit<cr>",
    },
    ["<leader>sh"] = {
      "<cmd>split<cr>",
    },
    ["s"] = false,
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["S"] = false,

    -- navigate buffer tabs with `H` and `L`
    ["tl"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["th"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<down>"] = {
      ":m .+1<CR>==",
    },
    ["<up>"] = {
      ":m .-2<CR>==",
    },
    ["<C-x>"] = {
      function() require("astronvim.utils.buffer").close() end,
      desc = "Close current buffer",
    },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["<leader>m"] = {
      function() require("harpoon.mark").add_file() end,
      desc = "add file to harpoon",
    },
    ["<leader>fm"] = {
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "show all files in harpoon",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
  i = {
    ["<down>"] = {
      "<Esc>:m .+1<CR>==gi",
    },
    ["<up>"] = {
      "<Esc>:m .-2<CR>==gi",
    },
  },
  v = {
    ["<down>"] = {
      ":m '>+1<CR>gv=gv",
    },
    ["<up>"] = {
      ":m '<-2<CR>gv=gv",
    },
  },
}
