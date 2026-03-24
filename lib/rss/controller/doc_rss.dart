import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trananhtin_flutter_app/rss/model/rss_item.dart';
import 'package:trananhtin_flutter_app/rss/model/rss_resource.dart';
import 'package:xml2json/xml2json.dart';

String _rssURLVNExpress ="https://vnexpress.net/rss/tin-moi-nhat.rss";

void main() async{

  final response = await http.get(Uri.parse(_rssURLVNExpress));
  if(response.statusCode == 200){
    // print(response.body);
    final xml2Json = Xml2Json();
    xml2Json.parse(utf8.decode(response.bodyBytes));
    String rssJson =xml2Json.toParker();
    // print(rssJson);
    Map<String, dynamic> jsonData = jsonDecode((rssJson));
    var testData = jsonData["rss"]["channel"]["item"][0];
    // print(testData);
    
    RssItem rssItem = RssItem.empty().fromJson(testData, r: rssResources[0]);
    print(rssItem.title);print("\n");
    print(rssItem.pubDate);print("\n");
    print(rssItem.description);print("\n");
    print(rssItem.link);print("\n");
    print(rssItem.imageUrl);print("\n");
  }
}