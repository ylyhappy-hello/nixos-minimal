{
  programs = {
    git = {
      enable = true;
      userName = "ylyhappy-hello";
      userEmail = "2778335106@qq.com";
      # signing = {
      #   key = "18B9F11F26C894A0D9E3F92BB26EAEB7189F30B4";
      #   signByDefault = true;
      # };
      extraConfig = {
        diff = { tool = "vscode"; };
        "difftool \"vscode\"" = { cmd = "code --wait --diff $LOCAL $REMOTE"; };
        merge = { tool = "vscode"; };
        "mergetool \"vscode\"" = { cmd = "code --wait $MERGED"; };
      };
    };
  };
}
