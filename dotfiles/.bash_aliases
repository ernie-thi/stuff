########################################################################
# Put this in .bashrc whether it not yet is there:
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
# if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases

########################################################################
# Also: command "alias" shows all aliases that are set. Command 'unalias' can delete a alias again


# Some bash aliases
alias ll='ls -alF'
alias la='ls -A' 
alias l='ls -CF'
alias h='history'
alias bashrc='nvim /home/raphael/.bashrc; source /home/raphael/.bashrc'
alias google='google-chrome &'
alias vim='nvim'
alias hw="inxi -Fxz"
alias pdf="pdflatex --shell-escape"
alias z="zathura"
alias sdn="shutdown now"
alias c="clear"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias cdi="cd ~/IT/"
alias cdg="cd ~/gh/"
alias py="python3"
alias xampp="sudo /opt/lampp/xampp"
