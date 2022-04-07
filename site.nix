{
  siteName = "testing";

  customMerges = {
    cssmerge = "./main.css";
    lasteditdate = "20220402";
  };

  templates = {
    index = builtins.readFile ./templates/index2.tmpl;
    article = ''
      <!--siteName-->
      <!--title-->
      ttttttttttttttttttttttttt
      <!--content-->
    '';
  };

  header = ''
HEAD
    '';

  footer = ''
FOOT
    '';

  articles = [
    {
      urlname = "howThisSiteIsBuild";
      title = "How this site is built";
      tags = [ "nix" "flakes" "static" ];
      content = ''
        Here is some content
      '';
    }
    {
      urlname = "concerningEngland";
      title = "Concerning England";
      tags = [ "England" ];
      content = ''
        Here is some more content
      '';
    }
  ];

}
