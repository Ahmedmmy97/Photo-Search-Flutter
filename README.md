# Photo Search App
Like a search engine which can search for photos on google images or flickr and display 100 result(can be increased).

## Google Images 
-creates a search url from query value then send an http request which return result page using [http package](https://pub.dev/packages/http) . 

-using [html parsers](https://pub.dev/packages/html) to query the recieved document for the div where search result urls are Stored.

-retrieving urls in **Future<List<String>>** and showing them in **Image.Network()** using Future Builder.


## Flicker
-uses flickr api to search results in form of  json object. 

-Create object from json response.

-Create static url for each photo.

-retrieving urls in **Future<List<String>>** and showing them in **Image.Network()** using Future Builder.
