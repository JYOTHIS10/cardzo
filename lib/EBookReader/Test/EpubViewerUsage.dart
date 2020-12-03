import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
// import 'package:epub_viewer/epub_viewer.dart';
import 'EpubViewer.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  // Dio dio = new Dio();

  @override
  void initState() {
    super.initState();
//    download();
  }

  download() async {
    if (Platform.isIOS) {
      print('download');
      // await downloadFile();
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: loading
              ? CircularProgressIndicator()
              : FlatButton(
                  onPressed: () async {
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    print('$appDocDir');

                    // String iosBookPath = '${appDocDir.path}/chair.epub';
                    // print(iosBookPath);
                    String androidBookPath = 'file:///android_asset/3.epub';
                    EpubViewer.setConfig(
                        themeColor: Theme.of(context).primaryColor,
                        identifier: "Book",
                        scrollDirection: EpubScrollDirection.HORIZONTAL,
                        allowSharing: true,
                        enableTts: true,
                        nightMode: true);
//                    EpubViewer.open(
//                      Platform.isAndroid ? androidBookPath : iosBookPath,
//                      lastLocation: EpubLocator.fromJson({
//                        "bookId": "2239",
//                        "href": "/OEBPS/ch06.xhtml",
//                        "created": 1539934158390,
//                        "locations": {
//                          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
//                        }
//                      }),
//                    );

                    await EpubViewer.openAsset(
                      'assets/ibe.epub',
                      lastLocation: EpubLocator.fromJson({
                        "bookId": "2239",
                        "href": "/OEBPS/ch06.xhtml",
                        "created": 1539934158390,
                        "locations": {
                          "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                        }
                      }),
                    );
                    // get current locator
                    EpubViewer.locatorStream.listen((locator) {
                      print(
                          'LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
                    });
                  },
                  child: Container(
                    child: Text('open epub'),
                  ),
                ),
        ),
      ),
    );
  }

// Creating A Temporary File to Open by EPUBViewer
  Future<File> _loadFromAssets(String assetName) async {
    final bytes = await rootBundle.load(assetName);
    String dir = (await getTemporaryDirectory()).path;
    String path = join(dir, 'one.epub');
    final buffer =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    return File(path).writeAsBytes(buffer);
  }

  // Future downloadFile() async {
  //   print('download1');
  //   PermissionStatus permission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.storage);

  //   if (permission != PermissionStatus.granted) {
  //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //     await startDownload();
  //   } else {
  //     await startDownload();
  //   }
  // }

  startDownload() async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir.path + '/chair.epub';
    File file = File(path);
//    await file.delete();

    // if (!File(path).existsSync()) {
    //   await file.create();
    //   await dio.download(
    //     'https://github.com/FolioReader/FolioReaderKit/raw/master/Example/'
    //     'Shared/Sample%20eBooks/The%20Silver%20Chair.epub',
    //     path,
    //     deleteOnError: true,
    //     onReceiveProgress: (receivedBytes, totalBytes) {
    //       print((receivedBytes / totalBytes * 100).toStringAsFixed(0));
    //       //Check if download is complete and close the alert dialog
    //       if (receivedBytes == totalBytes) {
    //         loading = false;
    //         setState(() {});
    //       }
    //     },
    //   );
    // } else {
    //   loading = false;
    //   setState(() {});
    // }
  }
}
