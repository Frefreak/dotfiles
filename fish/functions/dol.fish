function dol --wraps='dolphin . &> /dev/null &; disown'
dolphin . &> /dev/null &
disown
end
