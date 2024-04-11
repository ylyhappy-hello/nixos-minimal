function install
    if test -d $HOME/.local/nixos_config
        rm -rf $HOME/.local/nixos_config
    end
    git clone -b minimal  $HOME/.local/nixos_config
end
