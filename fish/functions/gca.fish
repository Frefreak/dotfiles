function gca --wraps='git commit --verbose --all' --description 'alias gca git commit --verbose --all'
  git commit --verbose --all $argv
        
end
