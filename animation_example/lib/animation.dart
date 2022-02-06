import 'package:flutter/material.dart';
import 'people.dart';
import 'second_page.dart';
import 'sliver_page.dart';

class AnimationApp extends StatefulWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  _AnimationAppState createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);
  int current = 0;
  double _opacity = 1;
  Color weightColor = Colors.blue;

  @override
  void initState() {
    peoples.add(People('스미스', 180, 92));
    peoples.add(People('Merry', 175, 92));
    peoples.add(People('존', 177, 75));
    peoples.add(People('바트', 130, 40));
    peoples.add(People('콘', 194, 140));
    peoples.add(People('디디', 100, 80));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation Example')),
      body: SizedBox(
        child: Center(
          child: Column(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: SizedBox(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text('이름 : ${peoples[current].name}'),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        child: Text(
                          '키 ${peoples[current].height}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].height,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        child: Text(
                          '몸무게 ${peoples[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].weight,
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        child: Text(
                          'bmi ${peoples[current].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center,
                        ),
                        width: 50,
                        height: peoples[current].bmi,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  height: 200,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current < peoples.length - 1) {
                        _changeWeightColor(peoples[current].weight);
                        current++;
                      }
                    });
                  },
                  child: Text('다음')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current > 0) {
                        _changeWeightColor(peoples[current].weight);
                        current--;
                      }
                    });
                  },
                  child: Text('이전')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_opacity == 0) {
                        _opacity = 1;
                      } else {
                        _opacity = 0;
                      }
                    });
                  },
                  child: Text('사라지기')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  child: SizedBox(
                    width: 200,
                    child: Row(
                      children: <Widget>[
                        Hero(
                          tag: 'detail',
                          child: Icon(Icons.cake),
                        ),
                        Text(
                          '이동하기',
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SliverPage()));
                    });
                  },
                  child: Text('페이지 이동'))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
