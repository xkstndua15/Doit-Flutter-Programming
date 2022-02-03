import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  const ImageWidgetApp({Key? key}) : super(key: key);

  @override
  _ImageWidgetAppState createState() => _ImageWidgetAppState();
}

class _ImageWidgetAppState extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Widget'),
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'image/flutter.png',
                width: 200,
                height: 100,
              ),
              Text(
                'Hello Flutter',
                style: TextStyle(
                    fontFamily: 'Pacifico', fontSize: 30, color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
