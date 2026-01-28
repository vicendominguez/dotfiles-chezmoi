return {
  {
    "echasnovski/mini.pairs",
    enabled = true,
    event = { "VeryLazy" },
    version = "*",
    opts = {
      modes = { insert = true, command = false, terminal = false },
      mappings = {
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ["["] = {
          action = "open",
          pair = "[]",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
        },
        ["{"] = {
          action = "open",
          pair = "{}",
          neigh_pattern = ".[%s%z%)}%]]",
          register = { cr = false },
        },
        ["("] = {
          action = "open",
          pair = "()",
          neigh_pattern = ".[%s%z%)]",
          register = { cr = false },
        },
        ['"'] = {
          action = "closeopen",
          pair = '""',
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        ["'"] = {
          action = "closeopen",
          pair = "''",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
        ["`"] = {
          action = "closeopen",
          pair = "``",
          neigh_pattern = "[^%w\\][^%w]",
          register = { cr = false },
        },
      },
    },
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.trailspace",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.hipatterns",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.git",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
}
