return {
  '3rd/image.nvim',
  opts = {
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        floating_windows = true, -- if true, images will be rendered in floating markdown windows
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
      },
    },
  },
}
