return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icons = {
                todo = {
                  done = {
                    icon = " "
                  },
                  cancelled = {
                    icon = ""
                  },
                  on_hold = {
                    icon = ""
                  },
                  pending = {
                    icon = ""
                  },
                  recurring = {
                    icon = ""
                  },
                  uncertain = {
                    icon = "?"
                  },
                  undone = {
                    icon = " "
                  },
                  urgent = {
                    icon = "!"
                  },
                },
              },
            }
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                work = "~/Notes/work",
                home = "~/Notes/home"
              },
              default_workspace = "home"
            }
          },
          ['core.export.markdown'] = {},
        }
      })
    end,
  }
}
