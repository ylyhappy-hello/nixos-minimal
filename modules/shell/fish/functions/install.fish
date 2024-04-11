function install
    if test -d $HOME/.local/nixos_config
        rm $HOME/.local/nixos_config
    end
    git clone -b main https://github.com/ylyhappy-hello/nixos-minimal.git --depth 1 $HOME/.local/nixos_config
    cd $HOME/.local/nixos_config
end
