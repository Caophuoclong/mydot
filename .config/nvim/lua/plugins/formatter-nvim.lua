local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    json = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    python = {
      function()
        return { exe = "black", args = { "-q", "-" }, stdin = true }
      end,
    },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = { "--config-path", "/Users/sam/.config/nvim/stylua.toml", "-" },
          stdin = true,
        }
      end,
    },
  },
})

vim.api.nvim_exec(
  [[
    augroup FormatAutogroup
      autocmd!
      autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx,*.rs,*.py,*.lua,*.json FormatWrite
    augroup END
  ]],
  true
)
