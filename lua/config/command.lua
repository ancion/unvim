local compileRun = function()
  vim.cmd("w")
  local ft = vim.bo.filetype
  if ft == "c" then
    vim.cmd("!g++ % -o %<")
    vim.cmd("!time ./%<")
  elseif ft == "cpp" then
    vim.cmd("!g++ -std=c++11 %  -Wall -o %<")
    vim.cmd("term ./%<")
  elseif ft == "markdown" then
    vim.cmd("InstantMarkdownPreview")
  elseif ft == "lua" then
    vim.cmd("TermExec cmd='lua %'")
  elseif ft == "go" then
    vim.cmd("TermExec cmd='go run .'")
  elseif ft == "rust" then
    vim.cmd("TermExec cmd='cargo run'")
  elseif ft == "dart" then
    vim.cmd("TermExec cmd='dart %'")
  elseif ft == "python" then
    vim.cmd("TermExec cmd='python3 %'")
  elseif ft == "html" then
    vim.cmd("TermExec cmd='live-server % &'")
  elseif ft == "sh" then
    vim.cmd("TermExec cmd='bash %'")
  elseif ft == "javascript" then
    vim.cmd("TermExec cmd='node --trace-warnings %'")
  end
end

vim.keymap.set("n", "<F58>", compileRun, { silent = true })
