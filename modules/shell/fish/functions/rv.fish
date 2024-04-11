function rv
    if not test -d $HOME/.local/.trash
        mkdir -p $HOME/.local/.trash
    end
    mv $argv $HOME/.local/.trash
end
