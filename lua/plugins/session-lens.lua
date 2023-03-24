return {
  'rmagatti/session-lens',
  keys = {
    { '<C-P>', function() require('session-lens').search_session() end }
  }
}
