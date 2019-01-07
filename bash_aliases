# sort by date modified
alias lt='ls -alt' 
# run ripgrep through less keeping formatting
alias rip='function _rip() { rg $1 $2 --pretty | less -r; };_rip' 
# df without virtual filesystems
alias dfs='df -h -x squashfs -x tmpfs'
