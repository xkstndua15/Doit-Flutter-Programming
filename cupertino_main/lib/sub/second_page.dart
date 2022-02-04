import 'package:flutter/cupertino.dart';
import '../animal_list.dart';

class SecondPage extends StatefulWidget {
  final List<Animal> animalList;
  const SecondPage({Key? key, required this.animalList}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _isFlying = false;
  String? _imagePath;
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text(
        '양서류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    1: SizedBox(
      child: Text(
        '포유류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
    2: SizedBox(
      child: Text(
        '파충류',
        textAlign: TextAlign.center,
      ),
      width: 80,
    ),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: SizedBox(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
              ),
              CupertinoSegmentedControl(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  groupValue: _kindChoice,
                  children: segmentWidgets,
                  onValueChanged: (int value) {
                    setState(() {
                      _kindChoice = value;
                    });
                  }),
              Row(
                children: <Widget>[
                  Text('날개가 존재합니까?'),
                  CupertinoSwitch(
                      value: _isFlying,
                      onChanged: (value) {
                        setState(() {
                          _isFlying = value;
                        });
                      }),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
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
                        'repo/images/bee.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/bee.png';
                      },
                    ),
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
                        'repo/images/dog.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/dog.png';
                      },
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'repo/images/fox.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/fox.png';
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
                        'repo/images/wolf.png',
                        width: 80,
                      ),
                      onTap: () {
                        _imagePath = 'repo/images/wolf.png';
                      },
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                  child: Text('동물 추가하기'),
                  onPressed: () {
                    widget.animalList.add(Animal(
                        animalName: _textController!.value.text,
                        animalKind: getKind(_kindChoice),
                        imagePath: _imagePath));
                  })
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return '양서류';
      case 1:
        return '포유류';
      case 2:
        return '파충류';
    }
  }
}
