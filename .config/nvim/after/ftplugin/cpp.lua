local function opts_with_desc(desc)
  return { desc = "nvim-tree: " .. desc, noremap = true, silent = true, nowait = true }
end

vim.keymap.set("n", "<leader>lcc", vim.cmd.ClangdSwitchSourceHeader, opts_with_desc("Switch to header/impl"))

vim.keymap.set("n", "<leader>lck", vim.cmd.ClangdSymbolInfo, opts_with_desc("Symbol Info"))

vim.keymap.set("n", "<leader>lct", vim.cmd.ClangdTypeHierarchy, opts_with_desc("See type hierarchy"))

vim.keymap.set({ "n", "v" }, "<leader>lci", vim.cmd.TSCppDefineClassFunc,
  opts_with_desc("Implement out of class member functions"))

vim.keymap.set("n", "<leader>lcI", vim.cmd.TSCppDefineClassFunc,
  opts_with_desc("Create a concrete class implementing all the pure virtual functions"))

vim.keymap.set("n", "<leader>lcb", vim.cmd.TSCppRuleOf5, opts_with_desc("Implement Big 5"))
