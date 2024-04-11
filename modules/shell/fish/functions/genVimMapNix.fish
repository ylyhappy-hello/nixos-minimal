#!/run/current-system/sw/bin/fish
function genVimMapNix
  set output_file "file_list.txt"
  set current_folder (pwd)
  set file_list
  set prefix

  # Remove the file if it already exists
  if test -f $output_file
    rm $output_file
    touch $output_file
  end

  # Use 'find' command to list files recursively and extract desired file path
  find $current_folder -type f | while read -l file_path
    set file_list[(math (count $file_list) + 1)] $file_path
  end

  for file in $file_list
    string match --quiet --regex 'vim/init.lua' $file
    if test $status = 0
      set _prefix (string match -rg '(/.*)vim/init.lua' $file)
      if test $status = 0
        set prefix $_prefix
      else
        echo "error not get prefix"
      end
    end
  end
  for file in $file_list
    set sourcefile (string match -rg "$prefix(.*)" $file)
    if test $status = 0
      # exclude path that not contain vim 
      string match -qvr "vim" $sourcefile
      if test $status = 0
        continue;
      end
      string match -qr '\.nix$' $sourcefile
      if test $status = 0
        set targetfile (string replace 'vim' 'home.file.".config/nvim' $sourcefile)
        set targetfile (string replace '.nix' '' $targetfile)
        echo "$targetfile\".text = import ./$sourcefile {inherit user pkgs;};"
      else 
        set targetfile (string replace 'vim' 'home.file.".config/nvim' $sourcefile)
        echo "$targetfile\".source = ./$sourcefile;"
      end
    end
  end
end
