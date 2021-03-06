import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:search_app/DataHelper.dart';
import 'package:search_app/DownloadPage.dart';


class SearchResults extends StatefulWidget {
  String searchQuery;
  SearchType type;
  SearchResults(this.searchQuery,this.type);

  @override
  State<StatefulWidget> createState() {
    return _SearchState(searchQuery,type);
  }
}

class _SearchState extends State<SearchResults> {
  String searchQuery;
  SearchType type;
  _SearchState(this.searchQuery,this.type);
  Future<List<String>> links;
  @override
  void initState() {
    

    super.initState();
    if(type == SearchType.Google)
    links = Datahelper.loadImagesFromGoogleTask(searchQuery);
    else
    links = Datahelper.loadImagesFromFlickrTask(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(40),
          child: Center(
            child: Text(
              searchQuery,
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        FutureBuilder<List<String>>(
          future: links,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(child: _creategrid(context, snapshot.data));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        )
      ],
    ));
  }

  Widget _creategrid(BuildContext context, List<String> links) {
    return links.length > 0
        ? GridView.builder(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(2.0),

            itemCount: links.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorDark)),
                  child: GestureDetector(
                    onTap: (){
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => DownloadPage(links[index],context,type))).then((value) {
                                   
                                    
                              });
                    },
                      child: Image.network(links[index], fit: BoxFit.cover)));
            },
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1.0,
            ),
          )
        : Center(
            child: Text("No Available Images"),
          );
  }
}
