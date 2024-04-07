function glog --wraps='git log --oneline --decorate --color --graph' --description 'alias glog git log --oneline --decorate --color --graph'
  git log --oneline --decorate --color --graph $argv
        
end
