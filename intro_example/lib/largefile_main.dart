import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class LargeFileMain extends StatefulWidget {
  const LargeFileMain({Key? key}) : super(key: key);

  @override
  _LargeFileMainState createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  final imgUrl =
      'https://www.motherjones.com/wp-content/uploads/2019/12/Getty121719.jpg?w=1200&h=630&crop=1';
  bool downloading = false;
  var progrssString = '';
  String? file = "";

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: imgUrl);
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_controller!.value.text, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progrssString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progrssString = 'Completed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(hintText: 'url 입력'),
        ),
      ),
      body: Center(
          child: downloading
              ? SizedBox(
                  height: 120.0,
                  width: 200.0,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Downloading File: $progrssString',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('No Data');
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return snapshot.data as Widget;
                        }
                    }
                    return Text('No Data');
                  },
                  future: downloadWidget(file!),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    FileImage(file).evict();

    if (exist) {
      return Center(
        child: Column(
          children: <Widget>[Image.file(file)],
        ),
      );
    } else {
      return Text('No Data');
    }
  }
}
