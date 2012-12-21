export PAGER=more
alias tail='colortail -k ~/.colortail/colortail-openstack.conf'
alias ps='ps -aufx'
alias vi='vim'

export PS1='\[\033[01;32m\]\h\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 "(%s)") \[\033[01;34m\]$\[\033[00m\] '

