require("nvchad.options")

-- add yours here!
local enable_providers = {
   "python3_provider",
   "node_provider",
   -- and so on
}

for _, plugin in pairs(enable_providers) do
   vim.g["loaded_" .. plugin] = nil
   if vim.fn.exists("provider_" .. plugin) == 1 then
      vim.cmd("runtime " .. plugin)
   end
end

-- local o = vim.o
-- o.cursorlineopt = 'both' -- to enable cursorline!
