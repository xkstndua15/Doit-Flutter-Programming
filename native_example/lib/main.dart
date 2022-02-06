import 'native_connect/android_connect.dart';
import 'native_connect/ios_connect.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOSConnect();
    } else {
      return AndroidConnect();
    }
  }
}
