function gca! --wraps='git commit --verbose --all --amend' --description 'alias gca! git commit --verbose --all --amend'
  git commit --verbose --all --amend $argv
        
end
