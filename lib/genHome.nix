with (import ./util.nix);

let
  genHome = s:
    let finalSet = checkHome s;
    in builtins.toFile "inedx.html" (buildArticleLinkList finalSet
      (customTagReplace finalSet.customMerges (replaceTitle finalSet)));

      checkHome = s: s // { 
        indexTemplate = ensureIndexTemplate s; 
        articleTemplate = ensureArticleTemplate s;
      };

  buildArticleLinkList = s: text:
    let linkList = map (x: makeLink x "articles") s.articles;
    in builtins.replaceStrings [ (buildTag "articles") ]
    [ (articleInsert linkList) ] text;

  articleInsert = s:
    let insert = builtins.concatStringsSep "\n" s;
    in builtins.replaceStrings [ "--artlist--" ] [ insert ]
    "<ul>--artlist--</ul>";

  replaceTitle = s:
    builtins.replaceStrings [ (buildTag "siteName") ] [ s.siteName ]
    (builtins.readFile s.indexTemplate);

  ensureIndexTemplate = s:
    if builtins.hasAttr "indexTemplate" s then
      s.indexTemplate
    else
      ../templates/index.tmpl;
  ensureArticleTemplate = s:
    if builtins.hasAttr "articleTemplate" s then
      s.indexTemplate
    else
      ../templates/article.tmpl;
in { genHome = genHome; }

