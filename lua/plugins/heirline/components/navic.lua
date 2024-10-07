return {
  condition = function()
    return require('nvim-navic').is_available()
  end,
  provider = function()
    return require('nvim-navic').get_location()
  end,
}
