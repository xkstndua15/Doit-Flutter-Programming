import 'package:flutter/material.dart';

class FirstApp extends StatelessWidget {
  const FirstApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: Center(
      child: Text('첫 번째 페이지'),
    )));
  }
}
