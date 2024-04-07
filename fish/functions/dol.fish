function dol --wraps='dolphin . &> /dev/null &; disown' --description 'alias dol dolphin . &> /dev/null &; disown'
  dolphin . &> /dev/null &; disown $argv
        
end
