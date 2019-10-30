import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:progress_dialog/progress_dialog.dart';
class DownloadPage extends StatefulWidget{
  var url;
  DownloadPage(this.url);
  @override
  State<StatefulWidget> createState() {
    return _DownloadPageState(url);
  }
  
}
class _DownloadPageState extends State<DownloadPage> {
  var url;
  Future<bool> downloaded;
  ProgressDialog pr ;
  int _progress;
  _DownloadPageState(this.url) {
    SystemChrome.setEnabledSystemUIOverlays([]);
     
                  
  }
  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
         pr.update(
                  progress: _progress*1.0,
                  message: "Please wait...",
                  progressWidget: Container(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator()),
                  maxProgress: 100.0,
                  progressTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                  messageTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w600),
                );
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    pr= new ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
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
                  downloaded = _download(url);
                 /* downloaded.then((value) {
                    if (value) _showdialog(context);
                  });*/
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

  Future<bool> _download(String url) async {
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
}
