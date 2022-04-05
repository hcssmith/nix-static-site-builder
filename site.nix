{
  siteName = "testing";
  indexTemplate = ./templates/index2.tmpl;
  articleTemplate = ./templates/article2.tmpl;

  customMerges = {
    cssmerge = "./main.css";
    lasteditdate = "20220402";
  };

  articles = [
    {
      urlname = "howThisSiteIsBuild";
      title = "How this site is built";
      tags = [ "nix" "flakes" "static" ];
      content = ''
        Here is some content
        '';
      customMerges = {
        test1 = "Test1";
      };
    }
    {
      urlname = "concerningEngland";
      title = "Concerning England";
      tags = [ "England" ];
      content = ''
        Here is some more content
        '';
        customMerges = {
          test2 = "rest2";
        };
      }
  ];
}
