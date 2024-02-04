#!/bin/sh
if  command -v starship >/dev/null 2>&1; then 
    echo "starship already installed"
else
    if command -v sudo >/dev/null; then
        curl -fsSL https://starship.rs/install.sh > /tmp/starship
        sudo /bin/sh /tmp/starship --force >> /dev/null
    else
        curl -fsSL https://starship.rs/install.sh > /tmp/starship
        /bin/sh /tmp/starship --force >> /dev/null
    fi
fi
echo "Run chsh -s $(which zsh)"
