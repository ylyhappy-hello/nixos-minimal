''
function date_str
  echo $(date +%Y-%m-%d %H:%M:%S)
end

function gcmsgct
  gcmsg $(date_str)
end

function rv
    if not test -d $HOME/.local/.trash
        mkdir -p $HOME/.local/.trash
    end
    mv $argv $HOME/.local/.trash
end
''
