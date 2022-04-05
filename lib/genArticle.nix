with (import ./util.nix);

let

  md = import ./markdown.nix;
  makeArticles = s: p:
    makeMultiCommand (makeArticleSub s.articles s p)
    "cp --sub1-- $out/articles/--sub2--";

  makeArticleSub = arts: s: p: map (a: printArticle (makeArticle a s p)) arts;

  printArticle = a: {
    name = a.name;
    nixname = builtins.toFile a.name a.content;
  };

  makeArticle = article: set: pkgs: {
    name = article.urlname;
    content = subArticle article set pkgs;
  };

  subArticle = article: set: pkgs:
    subInContent article (customTagReplace article
      (customTagReplace set
        (subInSiteName set (subInTitle article set.templates.article)))) pkgs;

  subInTitle = article: str:
    builtins.replaceStrings [ (buildTag "title") ] [ article.title ] str;

  subInSiteName = set: str:
    builtins.replaceStrings [ (buildTag "siteName") ] [ set.siteName ] str;

  subInContent = article: str: pkgs:
    let c = (md.convertMarkdown article.content article.title pkgs);
    in builtins.replaceStrings [ (buildTag "content") ] [ c ] str;

in { makeArticles = makeArticles; }
