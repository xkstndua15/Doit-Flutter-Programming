import 'dart:collection';
import '../animal_item.dart';

import 'package:flutter/material.dart';

class SecondApp extends StatefulWidget {
  @override
  _SecondAppState createState() => _SecondAppState();

  List<Animal>? list;
  SecondApp({Key? key, @required this.list}) : super(key: key);
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? _isFly = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            Row(
              children: <Widget>[
                Radio(
                    value: 0, groupValue: _radioValue, onChanged: _radioChange),
                Text('양서류'),
                Radio(
                    value: 1, groupValue: _radioValue, onChanged: _radioChange),
                Text('파충류'),
                Radio(
                    value: 2, groupValue: _radioValue, onChanged: _radioChange),
                Text('포유류'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('날 수 있나요?'),
                Checkbox(
                    value: _isFly,
                    onChanged: (bool? check) {
                      setState(() {
                        _isFly = check;
                      });
                    })
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/cow.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/cow.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/pig.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/pig.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/dog.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/dog.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/bee.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/bee.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/cat.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/cat.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/wolf.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/wolf.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset(
                      'repo/images/monkey.png',
                      width: 80,
                    ),
                    onTap: () {
                      _imagePath = 'repo/images/monkey.png';
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('동물 추가하기'),
              onPressed: () {
                var animal = Animal(
                    animalName: nameController.value.text,
                    kind: getKind(_radioValue),
                    imagePath: _imagePath,
                    isFly: _isFly);

                AlertDialog dialog = AlertDialog(
                  title: Text('동물 추가하기'),
                  content: Text(
                    '이 동물은${animal.animalName} 입니다.'
                    '또 동물의 종류는 ${animal.kind} 입니다.\n이 동물을 추가하시겠습니까?',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          widget.list?.add(animal);
                          Navigator.of(context).pop();
                        },
                        child: Text('예')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('아니오')),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
            )
          ],
        ),
      ),
    ));
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  }

  getKind(int? radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}
