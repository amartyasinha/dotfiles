-- 1. Open Neo-tree on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      desc = "Open Neo-tree on startup",
      callback = function()
        if vim.fn.argc() == 0 then
          require("neo-tree.command").execute({ action = "show" })
        end
      end,
    })

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
