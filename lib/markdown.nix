{
  convertMarkdown = text: tmpname: pkgs:
    let
      tmpMd = pkgs.runCommand tmpname { } ''
        echo "${text}" | ${pkgs.pandoc}/bin/pandoc --from=markdown --to=html > $out
      '';
    in builtins.readFile tmpMd;
}
