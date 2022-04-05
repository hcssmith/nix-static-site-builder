with (import ./genHome.nix);
with (import ./genArticle.nix);
with (import ./util.nix);
let
    makeSite = site: 
    let s = checkSite site;
     home = genHome s;
        article = makeArticles s;
    in 
    builtins.concatStringsSep "\n" [home article];

  checkSite = s:
    s // {
      templates = {
        index = ensureIndexTemplate s;
        article = ensureArticleTemplate s;
      };
    };
in {  makeSite = makeSite; }
