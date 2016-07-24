// jupyter nbextensions
// .jupyter/custom/custom.js
IPython.CodeCell.options_default.cm_config.autoCloseBrackets = false;
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  CodeMirror.Vim.map("H", "0", "normal");
  CodeMirror.Vim.map("L", "$", "normal");
  CodeMirror.Vim.map("jk", "<Esc>", "insert");
  CodeMirror.Vim.map(";", ":", "normal");
});
