return {
  'mfussenegger/nvim-jdtls',

  config = function()
    vim.lsp.config('jdtls', {
      settings = {
        java = {
          configuration = {
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- And search for `interface RuntimeOption`
            -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
            runtimes = {
              {
                name = 'JavaSE-1.8',
                path = '/Users/cesar.enrique/.sdkman/candidates/java/8.0.462-amzn',
              },
              {
                name = 'JavaSE-21',
                path = '/Users/cesar.enrique/.sdkman/candidates/java/21.0.8-amzn',
                default = true,
              },
              {
                name = 'JavaSE-17',
                path = '/Users/cesar.enrique/.sdkman/candidates/java/17.0.14-amzn',
              },
            },
          },
        },
      },
    })

    vim.lsp.enable({ 'jdtls' })
  end,
}
