with (import ./genHome.nix);
with (import ./genArticle.nix);
with (import ./util.nix);
let
  makeSite = site: pkgs:
    let
      s = checkSite site;
      home = genHome s;
      article = makeArticles s pkgs;
    in builtins.concatStringsSep "\n" [ home article ];

  checkSite = s:
    s // {
      templates = {
        index = ensureIndexTemplate s;
        article = ensureArticleTemplate s;
      };

      header = ensureHeader s;
      footer = ensureFooter s;
    };
in { makeSite = makeSite; }
