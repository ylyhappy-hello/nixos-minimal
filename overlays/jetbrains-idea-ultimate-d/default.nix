
(final: prev: {
  jetbrains-idea-ultimate-d = prev.jetbrains.idea-ultimate.overrideAttrs (finalAttrs: {
    vmoptsFile = ''sss'';
    installPhase = finalAttrs.installPhase + ''
                echo '
-javaagent:${(final.callPackage ./jetbrains-agent.nix { })}/ja-netfilter/ja-netfilter.jar
                            '>> $out/idea-ultimate/bin/idea64.vmoptions
    '';
  });
})

# --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED
# --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED

