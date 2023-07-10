local cmp_window = require("cmp.config.window")
local cmp_mapping = require("cmp.config.mapping")
local status_cmp_ok, cmp_types = pcall(require, "cmp.types.cmp")
if not status_cmp_ok then
  return
end

local SelectBehavior = cmp_types.SelectBehavior
-- CmpItemKind
-- CmpItemAbbr
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-cmdline",
    },
    opts = {
      experimental = {
        ghost_text = false,
        native_menu = false,
      },
      window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      },
      formatting = {
        fields = { "menu", "kind", "abbr" },
        max_width = 0,
        source_names = {
          nvim_lsp = "(LSP)",
          emoji = "(Emoji)",
          path = "(Path)",
          calc = "(Calc)",
          cmp_tabnine = "(Tabnine)",
          vsnip = "(Snippet)",
          luasnip = "(Snippet)",
          buffer = "(Buffer)",
          tmux = "(TMUX)",
          copilot = "(Copilot)",
          treesitter = "(TreeSitter)",
        },
        duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        },
        duplicates_default = 0,
      },
      mapping = cmp_mapping.preset.insert({
        ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = SelectBehavior.Select }), { "i" }),
        ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = SelectBehavior.Select }), { "i" }),
        ["<C-d>"] = cmp_mapping.scroll_docs(-4),
        ["<C-f>"] = cmp_mapping.scroll_docs(4),
        ["<C-Space>"] = cmp_mapping.complete(),
        ["<C-e>"] = cmp_mapping.abort(),
      }),

      cmdline = {
        enable = true,
        options = {
          {
            type = ":",
            sources = {
              { name = "path" },
              { name = "cmdline" },
            },
          },
          {
            type = { "/", "?" },
            sources = {
              { name = "buffer" },
            },
          },
        },
      },
    },
  },
}
