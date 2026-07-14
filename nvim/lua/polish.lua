-- Open Neo-tree on startup when no file is given
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open Neo-tree on startup",
  callback = function()
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ action = "show" })
    end
  end,
})

-- Suppress harmless libuv ENOENT noise from LSP file watchers
local _notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:find("watch.watch: ENOENT", 1, true) then return end
  _notify(msg, level, opts)
end

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
