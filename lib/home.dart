import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:search_app/DataHelper.dart';
import 'package:search_app/SearchResults.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HompageState();
  }
}

class _HompageState extends State<HomePage> {
  int _radioGroupValue = 0;
  final textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
          child: Image.asset("assets/logo.png"),
        ),
        Container(
          color: Color(0xFFECE8E5),
          margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: TextField(
            
            controller: textcontroller,
            textAlign: TextAlign.center,
            maxLines: 1,
            cursorColor: Theme.of(context).primaryColorDark,
            style: Theme.of(context).primaryTextTheme.subhead,
            decoration: InputDecoration(
                fillColor: Color(0xFFECE8E5),
                contentPadding: const EdgeInsets.symmetric(vertical: 7.0),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1.0, color: const Color(0xE4B9B5B5))),
                hintText: 'Search Images'),
          ),
        ),
        buildRadioGroup(context),
        FlatButton(
          child: Text(
            "Go!",
          ),
          textTheme: Theme.of(context).buttonTheme.textTheme,
          color: Color(0xFFECE8E5),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SearchResults(
                        textcontroller.text,
                        _radioGroupValue == 0
                            ? SearchType.Google
                            : SearchType.Flickr))).then((value) {})
          },
        ),
      ],
    );
  }

  Widget buildRadioGroup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 0,
          groupValue: _radioGroupValue,
          onChanged: _handleRadioValueChange1,
        ),
        new Text(
          'Google Photos',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: 1,
          groupValue: _radioGroupValue,
          onChanged: _handleRadioValueChange1,
        ),
        new Text(
          'Flickr',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioGroupValue = value;
    });
  }
}
