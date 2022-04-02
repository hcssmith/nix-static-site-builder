let
  makeLink = s: prefix:
    let
      pre = [ "--Name--" "--Url--" ];
      post = [
        s.title
        (if prefix == "" then
          s.urlname
        else
          "/" + builtins.concatStringsSep "/" [ prefix s.urlname ])
      ];
    in builtins.replaceStrings pre post
    ''<li><a href ="--Url--">--Name--</a></li>>'';

  customTagReplace = customMerges: text:
    let
      vallist = map (x: builtins.getAttr x customMerges)
        (builtins.attrNames customMerges);
      taglist = map (x: buildTag x) (builtins.attrNames customMerges);
    in builtins.replaceStrings taglist vallist text;

  buildTag = s: builtins.replaceStrings [ "tag" ] [ s ] "<!--tag-->";
in {
  makeLink = makeLink;
  buildTag = buildTag;
  customTagReplace = customTagReplace;
}
