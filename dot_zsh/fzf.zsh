if [[ ! "$PATH" == *$HOME/.zsh/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.zsh/fzf/bin"
fi

source "$HOME/.zsh/fzf/shell/completion.zsh"
source "$HOME/.zsh/fzf/shell/key-bindings.zsh"
