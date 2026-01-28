return {
  {
    "nvim-mini/mini.pairs",
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
    "nvim-mini/mini.comment",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "nvim-mini/mini.trailspace",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "nvim-mini/mini.splitjoin",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "nvim-mini/mini.hipatterns",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
  {
    "nvim-mini/mini-git",
    version = "*",
    opts = {},
    event = { "VeryLazy" },
  },
}
