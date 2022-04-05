with (import ./util.nix);

let

  makeArticles = s:
    makeMultiCommand (makeArticleSub s.articles s) "cp --sub1-- $out/articles/--sub2--";

  makeArticleSub = arts: s:
    map (a: printArticle (makeArticle a s)) arts;


  printArticle = a:
    { name = a.name;
    nixname = builtins.toFile a.name a.content;
  };

  makeArticle = article: set: {
    name = article.urlname;
    content = subArticle article set;
  };

  subArticle = article: set:
  subInContent article (customTagReplace article.customMerges 
  (customTagReplace set.customMerges
      (subInSiteName set
        (subInTitle article set.templates.article))));

  subInTitle = article: str:
    builtins.replaceStrings [ (buildTag "title") ] [ article.title ] str;

  subInSiteName = set: str:
    builtins.replaceStrings [ (buildTag "siteName") ] [ set.siteName ] str;

  subInContent = article: str:
    builtins.replaceStrings [ (buildTag "content") ] [ article.content ] str;

in { makeArticles = makeArticles; }
