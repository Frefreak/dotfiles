function jf --wraps='journalctl -f' --description 'alias jf journalctl -f'
  journalctl -f $argv
        
end
