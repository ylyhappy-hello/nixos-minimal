{pkgs, ...}:
{
  # environment.systemPackages = with pkgs; [ jetbrains-idea-ultimate-d ];
  environment.systemPackages = with pkgs; [ jetbrains.idea-ultimate ];
}
