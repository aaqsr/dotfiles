return {
  'chipsenkbeil/distant.nvim',
  branch = 'v0.3',
  config = function()
    require('distant'):setup()
  end
}

-- post install,
-- Execute :DistantInstall
-- Then do :DistantConnect ssh://example.com to connect
