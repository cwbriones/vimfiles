path=(
    $(brew --prefix coreutils)/libexec/gnubin
    /usr/local/bin
    /usr/local/sbin
    $DOTFILES/bin
    $HOME/bin
    $HOME/.local/bin
    $HOME/.cargo/bin
    $path
)

MANPATH=/usr/local/opt/coreutils/libexec/gnuman: