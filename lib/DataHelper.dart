import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:html/parser.dart' show parse;
import 'package:image_downloader/image_downloader.dart';
import 'package:search_app/FlickrModel.dart';

enum SearchType { Google, Flickr }

class Datahelper {
  static final String _API_KEY = "c9ca501d27bd752dcdbe0bd8313b41d4";
  static Future<List<String>> loadImagesFromGoogleTask(String query) async {
    var url = Uri.encodeFull(
        "https://www.google.com/search?q=" + query + "&tbm=isch&tbs=isz:m");

    final response = await http.get(url, headers: {
      "user-agent":
          "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"
    });
    List<String> links = new List<String>();
    if (response.statusCode == 200) {
      print(response.body);
      var document = parse(response.body);
      var elements = document.querySelectorAll("div.rg_meta");
      for (var element in elements) {
        if (element.hasChildNodes()) {
          print(element.firstChild.toString());
          var jsondecoded = jsonDecode(element.firstChild
              .toString()
              .substring(1, element.firstChild.toString().length - 1));
          print(jsondecoded['ou']);
          links.add(jsondecoded['ou']);
        }
      }

      return links;
    } else
      throw Exception('Failed');
  }

  static Future<bool> downloadImageFromURL(String url) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return false;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      print(error);
    }
    return true;
  }

  static Future<List<String>> loadImagesFromFlickrTask(String query) async {
    final response = await http.get(_createURL(query), headers: {
      "user-agent":
          "Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"
    });
    print(response.body);
    var json = jsonDecode(response.body);
    var flickrData = FlickrData.fromJson(json);
    return _createPhotosUrlsFormData(flickrData);
  }

  static List<String> _createPhotosUrlsFormData(FlickrData data) {
    List<String> returnedURLS = new List<String>();

    if (data.stat == "ok") {
      for (Photo photo in data.photos.photo) {
        //http://farm{farmid}.staticflicker.com/{server-id}/{id}_{secret}{size}.jpg
        String photourl =
            "http://farm${photo.farm}.staticflickr.com/${photo.server}/${photo.id}_${photo.secret}_n.jpg";
        returnedURLS.add(photourl);
      }
    }
    return returnedURLS;
  }

  static String _createURL(String query) {
    String baseUrl = "https://www.flickr.com/services/rest/" +
        "?method=flickr.photos.search" +
        "&api_key=$_API_KEY" +
        "&text=$query" +
        "&format=json" +
        "&nojsoncallback=1";

    return Uri.encodeFull(baseUrl);
  }
}
