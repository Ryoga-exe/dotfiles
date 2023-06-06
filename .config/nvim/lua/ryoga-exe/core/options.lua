local opt = vim.opt

-- encoding
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- line numbers
opt.number = true
opt.relativenumber = true

-- tab & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

-- backspace
opt.backspace = 'indent,eol,start'

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append('-')
