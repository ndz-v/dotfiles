
vim.g.mapleader = " "

local opt = vim.opt

opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.tabstop = 4    -- number of tabs
opt.shiftwidth = 4 -- number of indentation
opt.softtabstop = 4
opt.iskeyword:append('-')
opt.mouse:append('a')
opt.clipboard:append('unnamedplus')
opt.encoding = 'UTF-8'
opt.completeopt = 'menuone,noinsert,noselect'

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Behavior
-- opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand('~/.vim/undodir')
opt.undofile = true
opt.backspace = 'indent,eol,start'
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.modifiable = true
opt.encoding = 'UTF-8'

if vim.g.vscode then

    local explorer = function()
        vim.fn.VSCodeNotify("workbench.view.explorer")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>e", explorer)

    local toggleSidebarVisibility = function()
        vim.fn.VSCodeNotify("workbench.action.toggleSidebarVisibility")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>m", toggleSidebarVisibility)

    local openRecent = function()
        vim.fn.VSCodeNotify("workbench.action.openRecent")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>r", openRecent)

    -- quick search

    local quickTextSearch = function()
        vim.fn.VSCodeNotify("workbench.action.experimental.quickTextSearch")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>q", quickTextSearch)

else

    -- Appearance
    opt.number = true
    opt.relativenumber = true
    opt.cmdheight = 1
    opt.scrolloff = 10
    opt.completeopt = 'menuone,noinsert,noselect'

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- Directory Navigation

    keymap.set("n", "<C-d>", "<C-d>zz", opts)
    keymap.set("n", "<C-u>", "<C-u>zz", opts)

    -- Window Management
    keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)          -- Split Vertically
    keymap.set("n", "<leader>sh", ":split<CR>", opts)           -- Split Horizontally
    keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize

    -- Comments
    vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
    vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

end
