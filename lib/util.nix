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
  
  makeMultiCommand = list: string:
    let l = map (x: (builtins.replaceStrings [ "--sub1--" "--sub2--" ] [ x.nixname x.name ] string)) list;
    in
    builtins.concatStringsSep "\n" l; 
  
  ensureIndexTemplate = s:
    if builtins.hasAttr "index" s.templates then
      s.templates.index
    else
      builtins.readFile ../templates/index.tmpl;
  ensureArticleTemplate = s:
    if builtins.hasAttr "article" s.templates then
      s.templates.article
    else
      builtins.readFile ../templates/article.tmpl;

in {
  makeLink = makeLink;
  buildTag = buildTag;
  customTagReplace = customTagReplace;
  makeMultiCommand = makeMultiCommand;
  ensureIndexTemplate = ensureIndexTemplate;
  ensureArticleTemplate = ensureArticleTemplate;
}
