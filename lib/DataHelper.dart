import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:html/parser.dart' show parse;

class LoadImagesFromGoogleTask {

 static Future<List<String>> fetchLinks(String query) async {
  var url = Uri.encodeFull("https://www.google.com/search?q=" + query + "&tbm=isch&tbs=isz:m");

  final response = await http.get(url,headers: {"user-agent":"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"});
  List<String> links = new List<String>();
  if (response.statusCode == 200){
     print(response.body);
     var document = parse(response.body);
     var elements = document.querySelectorAll("div.rg_meta");
     for (var element in elements) {
       if(element.hasChildNodes()){
       print(element.firstChild.toString());
         var jsondecoded = jsonDecode(element.firstChild.toString().substring(1,element.firstChild.toString().length-1));
         print(jsondecoded['ou']);
         links.add(jsondecoded['ou']);
       }
     }
      
    
      
    return links;
  }
  else throw Exception('Failed');
}

}
