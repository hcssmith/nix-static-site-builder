with (import ./util.nix);

let

  genHome = s:
    let
      nixfilename = builtins.toFile "index.html" content;

    content = s.header + (buildArticleLinkList s
    (customTagReplace s (replaceTitle s))) + s.footer;
     
    in builtins.replaceStrings [ "--sub--" ] [ nixfilename ]
    "cp --sub-- $out/index.html";

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
    s.templates.index;

in { genHome = genHome; }

