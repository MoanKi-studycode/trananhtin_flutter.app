class RssResource {
  String id, name;
  String startDecriptionRegrex, endDecriptionRegrex;
  String startImageRegrex, endImageRegrex;
  Map<String, String> resourceHeaders;

  RssResource({
    required this.id,
    required this.name,
    required this.startDecriptionRegrex,
    required this.endDecriptionRegrex,
    required this.startImageRegrex,
    required this.endImageRegrex,
    required this.resourceHeaders,
  });
}

List<RssResource> rssResources = [
  RssResource(
    id: "vnexpress", 
    name: "VnExpress", 
    startDecriptionRegrex: "</a></br>", 
    endDecriptionRegrex: "", 
    startImageRegrex: '<img src="', 
    endImageRegrex: '"', 
    resourceHeaders: {
      "Trang chủ" : "https://vnexpress.net/rss/tin-moi-nhat.rss",
      "Thời sự" : "https://vnexpress.net/rss/thoi-su.rss",
      "Giải trí" : "https://vnexpress.net/rss/giai-tri.rss",
      "Pháp luật" : "https://vnexpress.net/rss/phap-luat.rss",
    }
  ),
  RssResource(
    id: "tuoitre", 
    name: "Tuổi Trẻ", 
    startDecriptionRegrex: "</a>",
    endDecriptionRegrex: "",
    startImageRegrex: '<img src="', 
    endImageRegrex: '"', 
    resourceHeaders: {
      "Trang chủ" : "https://tuoitre.vn/rss/tin-moi-nhat.rss",
      "Thời sự" : "https://tuoitre.vn/rss/thoi-su.rss",
      "Giải trí" : "https://tuoitre.vn/rss/giai-tri.rss",
      "Pháp luật" : "https://tuoitre.vn/rss/phap-luat.rss",
    }
  ),
];
