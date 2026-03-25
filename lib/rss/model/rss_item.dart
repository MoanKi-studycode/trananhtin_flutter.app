import 'package:trananhtin_flutter_app/rss/model/rss_resource.dart';

class RssItem {
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  RssItem.empty();

  RssItem fromJson(Map<String, dynamic> json, {required RssResource r}){
    title = json['title'];
    pubDate = json['pubDate'];
    
    String rawDescription = "";
    if (json['description'] != null) {
      if (json['description'] is String) {
        rawDescription = json['description'];
      } else if (json['description'] is Map && json['description']['__cdata'] != null) {
        rawDescription = json['description']['__cdata'];
      } else if (json['description'] is Map && json['description']['#text'] != null) {
        rawDescription = json['description']['#text'];
      }
    }

    description = _getDecription(rawDescription, r: r);
    link = json['link'];
    imageUrl = _getImageUrl(rawDescription, r: r);
    return this;
  }

  String _getDecription(String rawDecription, {required RssResource r}){
    if (rawDecription.isEmpty) return "";
    String startRegrex = r.startDecriptionRegrex;
    String endRegrex = r.endDecriptionRegrex;
    
    int startIndex = rawDecription.indexOf(startRegrex);
    String result = "";
    if (startIndex != -1) {
      int start = startIndex + startRegrex.length;
      if(endRegrex.isNotEmpty){
        int end = rawDecription.indexOf(endRegrex, start);
        if (end != -1) {
          result = rawDecription.substring(start, end);
        }
      } else {
        result = rawDecription.substring(start);
      }
    } else {
      result = rawDecription;
    }

    // Clean up common HTML tags that often remain
    return result
        .replaceAll('</br>', '')
        .replaceAll('<br>', '')
        .replaceAll('<br/>', '')
        .replaceAll('&nbsp;', ' ')
        .trim();
  }

  String? _getImageUrl(String rawDecription, {required RssResource r}){
    if (rawDecription.isEmpty) return null;
    String startRegrex = r.startImageRegrex;
    String endRegrex = r.endImageRegrex;
    
    int startIndex = rawDecription.indexOf(startRegrex);
    if (startIndex != -1) {
      int start = startIndex + startRegrex.length;
      if(endRegrex.isNotEmpty){
        int end = rawDecription.indexOf(endRegrex, start);
        if (end != -1) {
          return rawDecription.substring(start, end);
        }
      }
      return rawDecription.substring(start);
    }
    return null;
  }
}
