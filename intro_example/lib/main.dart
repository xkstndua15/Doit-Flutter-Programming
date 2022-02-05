import 'package:flutter/material.dart';
import 'largefile_main.dart';
import 'intropage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: IntroPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Logo'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LargeFileMain()));
              },
              child: Text('로고 바꾸기', style: TextStyle(color: Colors.white)))
        ],
      ),
    );
  }
}
