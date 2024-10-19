function create_coq_bind(key, action)
  vim.keymap.set(
    'n',
    string.format("%s", key),
    string.format("<Plug>%s", action),
    { buffer = true, desc = action })
end

create_coq_bind("<leader>cc", "CoqInterrupt")
create_coq_bind("<leader>cq", "CoqStop")
create_coq_bind("<leader>cj", "CoqNext")
create_coq_bind("<leader>ck", "CoqUndo")
create_coq_bind("<leader>cl", "CoqToLine")
create_coq_bind("<leader><leader>", "CoqToLine")
create_coq_bind("<M-Down>", "CoqNext")
create_coq_bind("<M-Up>", "CoqUndo")
