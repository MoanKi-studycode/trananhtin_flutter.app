import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trananhtin_flutter_app/rss/model/rss_item.dart';
import 'package:trananhtin_flutter_app/rss/model/rss_resource.dart';
import 'package:xml2json/xml2json.dart';

class SimpleControllerRss extends GetxController{
  List<RssResource> resources = rssResources;
  late RssResource currentResource;
  String? _rssUrl;
  String? _resourceHeader;
  var _rssList = <RssItem>[];

  List<RssItem> get rssList => _rssList;
  String get currentResourceName => currentResource.name;
  String? get resourceHeader => _resourceHeader;
  List<String> get headerResources => currentResource.resourceHeaders.keys.toList();

  @override
  void onInit() {
    super.onInit();
    currentResource = rssResources[0];
    _resourceHeader = currentResource.resourceHeaders.keys.first;
    _rssUrl = currentResource.resourceHeaders[_resourceHeader];
  }

  @override
  void onReady(){
    super.onReady();
    readRss();
  }

  void changeResourceHeader(String header) {
    if (currentResource.resourceHeaders.containsKey(header)) {
      _resourceHeader = header;
      _rssUrl = currentResource.resourceHeaders[header];
      _rssList = [];
      update(["rssList", "header"]);
      readRss();
    }
  }

  void changeResource(String resourceName) {
    if(resourceName != currentResourceName){
      for (var r in resources) {
        if (r.name == resourceName) {
          currentResource = r;
          break;
        }
      }
      _resourceHeader = currentResource.resourceHeaders.keys.first;
      _rssUrl = currentResource.resourceHeaders[_resourceHeader];
      _rssList = [];
      update(["rssList", "header", "resourceName"]);
      readRss();
    }
  }

  Future<void> readRss() async{
    if (_rssUrl == null) return;
    
    _fetchRSS(_rssUrl!)
        .then(
          (value) {
            _rssList = value?.map(
              (e) => RssItem.empty().fromJson(e, r: currentResource),
            ).toList()?? [];
            update(["rssList"]);
          },
    ).onError(
        (error, stackTrace) {
          print("Loi doc Rss $error");
          _rssList = [];
          update(["rssList"]);
        },
    );
  }

  Future<List<dynamic>?> _fetchRSS(String rssURL) async {
    try {
      final response = await http.get(Uri.parse(rssURL));
      if (response.statusCode == 200) {
        final xml2Json = Xml2Json();
        xml2Json.parse(utf8.decode(response.bodyBytes));
        String rssJson = xml2Json.toParker();
        Map<String, dynamic> jsonData = jsonDecode(rssJson);
        
        if (jsonData["rss"] != null && 
            jsonData["rss"]["channel"] != null && 
            jsonData["rss"]["channel"]["item"] != null) {
          var items = jsonData["rss"]["channel"]["item"];
          if (items is List) {
            return items;
          } else {
            return [items];
          }
        }
      }
    } catch (e) {
      print("Exception reading rss: $e");
    }
    return null;
  }
}
