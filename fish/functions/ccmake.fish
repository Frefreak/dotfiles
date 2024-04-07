function ccmake --wraps='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES' --description 'alias ccmake cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES'
  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES $argv
        
end
