''
# fcitx5 如果是中文输入法执行这个函数就会切换到英文输入法，给vim用
function im_change
  set -f im $(fcitx5-remote)
  if test $im -eq 2
    fcitx5-remote -c
  end
end
''
