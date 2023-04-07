require'nvim-tree'.setup {
  renderer = {
    indent_markers = {
        enable = true,
    }
  },
  view = {
    side = 'left',
    width = 32
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
}
