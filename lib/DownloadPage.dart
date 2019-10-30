import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:search_app/DataHelper.dart';

class DownloadPage extends StatefulWidget {
  var url;
  BuildContext context;
  DownloadPage(this.url,this.context);
  @override
  State<StatefulWidget> createState() {
    return _DownloadPageState(url,context);
  }
}

class _DownloadPageState extends State<DownloadPage> {
  var url;
  Future<bool> downloaded;
  ProgressDialog pr;
  double _progress=0;
  _DownloadPageState(this.url,context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
     pr = new ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: true, showLogs: true);
    pr.style(
      message: 'Downloading file...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }
  @override
  void initState() {
    super.initState();
    
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress*1.0;
        print("Progress: " + progress.toString());
        pr.update(
          progress:_progress,
        );
      });
     
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Image.network(url),
        ),
        Container(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: Theme.of(context).primaryColorLight,
                child: Text(
                  "Download",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () {
                  pr.show();
                  downloaded = Datahelper.DownloadImageFromURL(url);
                   downloaded.then((value) {
                     pr.hide();
                    if (value) _showdialog(context);
                  });
                },
              ),
            ))
      ],
    ));
  }

  void _showdialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Info"),
            content: Text("Downloaded Successfully"),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

 
}
