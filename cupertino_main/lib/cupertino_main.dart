import 'package:flutter/cupertino.dart';
import 'sub/first_page.dart';
import 'sub/second_page.dart';
import 'animal_list.dart';

class CupertinoMain extends StatefulWidget {
  const CupertinoMain({Key? key}) : super(key: key);

  @override
  _CupertinoMainState createState() => _CupertinoMainState();
}

class _CupertinoMainState extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add))
    ]);

    animalList.add(Animal(
        animalName: "벌",
        animalKind: "곤충",
        imagePath: "repo/images/bee.png",
        isFlying: true));
    animalList.add(Animal(
        animalName: "고양이",
        animalKind: "포유류",
        imagePath: "repo/images/cat.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "소",
        animalKind: "포유류",
        imagePath: "repo/images/cow.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "강아지",
        animalKind: "포유류",
        imagePath: "repo/images/dog.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "여우",
        animalKind: "포유류",
        imagePath: "repo/images/fox.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "원숭이",
        animalKind: "영장류",
        imagePath: "repo/images/monkey.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "돼지",
        animalKind: "포유류",
        imagePath: "repo/images/pig.png",
        isFlying: false));
    animalList.add(Animal(
        animalName: "늑대",
        animalKind: "포유류",
        imagePath: "repo/images/wolf.png",
        isFlying: false));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar!,
        tabBuilder: (context, value) {
          if (value == 0) {
            return FirstPage(animalList: animalList);
          } else {
            return SecondPage(
              animalList: animalList,
            );
          }
        },
      ),
    );
  }
}
