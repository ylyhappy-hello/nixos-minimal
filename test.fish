
function cdwm 
  set -f dwm $(nix-store --query --tree result | rg -i yly-dwm | head -1 | rg '//*.*' -o)
  cd $dwm
end
