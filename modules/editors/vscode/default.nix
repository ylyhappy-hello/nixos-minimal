{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions;
        [
          alefragnani.bookmarks
          # bradlc.vscode-tailwindcss 
          christian-kohler.path-intellisense
          #clinyong.vscode-css-modules 
          codezombiech.gitignore
          edonet.vscode-command-runner
          #csstools.postcss 
          # dbaeumer.vscode-eslint 
          #dsznajder.es7-react-js-snippets 
          #elemefe.vscode-element-helper 
          #eriklynd.json-tools 
          esbenp.prettier-vscode
          formulahendry.auto-close-tag
          golang.go
          gruntfuggly.todo-tree
          #hbenl.vscode-test-explorer 
          # humao.rest-client 
          #jingwang37.element-plus-snippets 
          lokalise.i18n-ally
          #mgmcdermott.vscode-language-babel 
          ms-ceintl.vscode-language-pack-zh-hans
          ms-vscode.cmake-tools
          ms-vscode.cpptools
          ms-vscode-remote.remote-ssh
          naumovs.color-highlight
          #nickdemayo.vscode-json-editor 
          oderwat.indent-rainbow
          pkief.material-icon-theme
          redhat.vscode-yaml
          #sachinb94.css-tree 
          #steoates.autoimport 
          #stylelint.vscode-stylelint 
          #syler.sass-indented 
          #tomasvergara.vscode-fontawesome-gallery 
          twxs.cmake
          #tyriar.lorem-ipsum 
          #voorjaar.windicss-intellisense 
          vscode-icons-team.vscode-icons
          vscodevim.vim
          #wayou.vscode-todo-highlight 
          #yzdel2000.uni-app-devtools 
          zhuangtongfa.material-theme
        ] ++ vscode-utils.extensionsFromVscodeMarketplace ([ ] ++ (import ./vue)
#          ++ (import ./java)
          ++ (import ./docker)
          ++ [
            {
              name = "multi-command";
              publisher = "ryuta46";
              version = "1.6.0";
              sha256 = "sha256-AnHN1wvyVrZRlnOgxBK7xKLcL7SlAEKDcw6lEf+2J2E=";
            }
            {
              name = "nixfmt-vscode";
              publisher = "brettm12345";
              version = "0.0.1";
              sha256 = "sha256-8yglQDUc0CXG2EMi2/HXDJsxmXJ4YHvjNjTMnQwrgx8=";
            }
            {
              name = "nix-ide";
              publisher = "jnoortheen";
              version = "0.2.2";
              sha256 = "sha256-jwOM+6LnHyCkvhOTVSTUZvgx77jAg6hFCCpBqY8AxIg=";
            }
            {
              name = "LiveServer";
              publisher = "ritwickdey";
              version = "5.7.9";
              sha256 = "sha256-w0CYSEOdltwMFzm5ZhOxSrxqQ1y4+gLfB8L+EFFgzDc=";
            }
          # morkdown中文指北
            {
              name = "autocorrect";
              publisher = "huacnlee";
              version = "2.6.4";
              sha256 = "sha256-1cN36FnslttmH66J4Xah1KohM2nEQckNUXHZD+ps2uY=";
            }
          ]);
    })
  ];
}
