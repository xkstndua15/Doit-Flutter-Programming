import 'package:flutter/material.dart';
import 'sub/first_page.dart';
import 'sub/second_page.dart';
import 'animal_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewApp(),
    );
  }
}

class ListViewApp extends StatefulWidget {
  const ListViewApp({Key? key}) : super(key: key);

  @override
  _ListViewAppState createState() => _ListViewAppState();
}

class _ListViewAppState extends State<ListViewApp>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(
        Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png"));
    animalList.add(Animal(
        animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png"));
    animalList.add(Animal(
        animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png"));
    animalList.add(Animal(
        animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png"));
    animalList.add(Animal(
        animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png"));
    animalList.add(Animal(
        animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png"));
    animalList.add(Animal(
        animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png"));
    animalList.add(Animal(
        animalName: "원숭이", kind: "영장류", imagePath: "repo/images/monkey.png"));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(
            list: animalList,
          ),
          SecondApp(list: animalList)
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(
            icon: Icon(
              Icons.looks_one,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ),
          ),
        ],
        controller: controller,
      ),
    );
  }
}
