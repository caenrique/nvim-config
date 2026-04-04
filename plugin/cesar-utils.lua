local M = {}

---@type vim.log.levels
M.log_level = vim.log.levels.WARN

--- Require a lua module if is available. Don't fail if it isn't.
---@param module string
---@param opts {opts?:table, after?:function, func?:string, enable?:boolean}
function M.require(module, opts)
  if opts.enable ~= nil and opts.enable == false then return end
  local ok, err = pcall(require, module)
  if ok then
    if opts.opts then
      if opts.func then
        require(module)[opts.func](opts.opts)
      else
        require(module).setup(opts.opts)
      end
    end
    if opts.after and type(opts.after) == 'function' then opts.after() end
  else
    if Cesar.log_level <= vim.log.levels.WARN then
      vim.print(string.format('[WARN] cesar-utils: %s', err))
    end
  end
end

---@class WithOpts<T>: { callback: (fun(module:table):T) , default:(fun():T)|T }

--- Evaluate a callback if a module is available. Return a default if not.
---@generic H
---@param modulename string
---@param opts WithOpts<H>
---@return H
function M.with(modulename, opts)
  local ok, module = pcall(require, modulename)
  if ok then
    return opts.callback(module)
  else
    if type(opts.default) == 'function' then
      return opts.default()
    else
      return opts.default
    end
  end
end

_G.Cesar = M
