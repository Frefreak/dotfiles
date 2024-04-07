set -x FZF_DEFAULT_COMMAND 'rg --files --hidden'
# many implementions may need to improve in the future
alias ff fzf_fuzzy_files
alias fg fzf_fuzzy_grep
alias fkill fzf_fuzzy_kill
alias fo fzf_nvim_oldfiles
fzf --fish | source
