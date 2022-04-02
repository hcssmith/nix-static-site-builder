with (import ./util.nix);

let
  makeArticles = s:
    map (x: makeArticle x) s.article;

    makeArticle = article: set:
      
# get template from set,
# sub in SiteName
# sub in Title
# sub in tags
# sub in content
# sub in set custom merges
# sub in article custom merges



in {
  makeArticles = makeArticles;
}
