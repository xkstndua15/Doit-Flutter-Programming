import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'native_app.dart';
import '../send_data_example.dart';

class AndroidConnect extends StatelessWidget {
  const AndroidConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SendDataExample(),
    );
  }
}
