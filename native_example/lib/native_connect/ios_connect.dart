import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'native_app.dart';

class IOSConnect extends StatelessWidget {
  const IOSConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: NativeApp(),
    );
  }
}
