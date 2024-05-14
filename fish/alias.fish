alias -s n nvim
alias -s m make
alias -s grep "grep -P --color=auto"
alias -s jf "journalctl -f"
alias -s a2 aria2c
alias -s dol "dolphin . &> /dev/null &; disown"
alias -s nvsmi nvidia-smi
alias -s ccmake "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=YES"
alias -s cm cmake
alias -s virsh 'virsh -c qemu:///system'
alias -s checksec 'pwn checksec'
alias -s hv hexyl
alias -s mpv 'mpv --cover-art-auto=no'
alias -s kr okular

# git
alias -s g "git"
alias -s gss "git status -s"
alias -s gco "git checkout"
alias -s gcb "git checkout -b"
alias -s glog "git log --oneline --decorate --color --graph"
alias -s gd "git diff"
alias -s ga "git add"
alias -s gca "git commit --verbose --all"
alias -s gca! "git commit --verbose --all --amend"
alias -s gl "git pull"
alias -s gp "git push"
alias -s gba "git branch --all"
alias -s gr "git remote"
alias -s grv "git remote --verbose"
