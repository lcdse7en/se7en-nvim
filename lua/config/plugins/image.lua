return {
  {
    '3rd/image.nvim',
    enabled = false,
    dependencies = { 'luarocks.nvim' },
    ft = { 'markdown', 'vimwiki', 'norg', 'org' },
    opts = {
      -- backend = 'kitty',
      backend = 'wezterm',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
          download_remote_images = true,
          filetypes = { 'markdown', 'vimwiki' },
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'norg' },
        },
        html = { enabled = false },
        css = { enabled = false },
      },
      max_width = 100,
      max_height = 25,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
      hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif', '*.svg' },
    },
    config = function(_, opts)
      require('image').setup(opts)
    end,
  },
}
