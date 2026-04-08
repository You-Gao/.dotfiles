local lint = require('lint')

lint.linters_by_ft = {
  markdown = { 'proselint', 'markdownlint-cli2' },
}

local markdownlint = lint.linters['markdownlint-cli2']

markdownlint.args = {
    "--config", vim.fn.expand("~/.markdownlint-cli2.yaml"), "-"
}





