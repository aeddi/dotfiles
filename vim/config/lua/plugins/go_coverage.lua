return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
      {
        "andythigpen/nvim-coverage",
        dependencies = {
          -- Disable treesitter move textobjects https://github.com/LazyVim/LazyVim/blob/16a772452a515790c3304b358dd66a618fda3260/lua/lazyvim/plugins/treesitter.lua#L79
          {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
              opts.textobjects = {
                move = {
                  enable = false,
                },
              }
              return opts
            end,
          },
        },
        version = "*",
        config = function()
          local coverage = require("coverage")

          -- Init coverage plugin
          coverage.setup({
            auto_reload = false, -- Bound test results to reload coverage
            commands = false,
          })

          -- Reload coverage when entering a go file
          vim.api.nvim_create_autocmd("BufEnter", {
            pattern = { "*.go" },
            callback = function()
              coverage.load(true)
            end,
          })
        end,
        keys = {
          {
            "<leader>tc",
            function()
              require("coverage").summary()
            end,
            desc = "Open Coverage summary",
          },
          {
            "]c",
            function()
              require("coverage").jump_next("uncovered")
            end,
            desc = "Next uncovered line",
          },
          {
            "[c",
            function()
              require("coverage").jump_prev("uncovered")
            end,
            desc = "Prev uncovered line",
          },
          {
            "]C",
            function()
              require("coverage").jump_next("partial")
            end,
            desc = "Next partially uncovered line",
          },
          {
            "[C",
            function()
              require("coverage").jump_prev("partial")
            end,
            desc = "Prev partially uncovered line",
          },
        },
      },
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          runner = "go",
          go_test_args = {
            "-v",
            "-race",
            "-count=1",
            "-timeout=60s",
            "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
          },
          dap_go_enabled = true, -- requires leoluz/nvim-dap-go
        },
      },
      consumers = {
        -- Load coverage on go buffer when tests results are available
        ["coverage"] = function(client)
          client.listeners.results = function(_, _)
            if vim.bo.filetype == "go" then
              require("coverage").load(true)
            end
          end
        end,
      },
    },
    keys = {
      {
        "<leader>tp",
        function()
          if vim.bo.filetype == "go" then
            require("neotest").run.run(vim.fn.expand("%:p:h"))
          else
            vim.notify(
              "Can't run package tests for " .. vim.bo.filetype .. " filetype",
              vim.log.levels.WARN,
              { title = "Neotest" }
            )
          end
        end,
        desc = "Run Package (Neotest)",
      },
    },
  },
}
