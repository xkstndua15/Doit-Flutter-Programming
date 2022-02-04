import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondDetail extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  SecondDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.value.text);
                },
                child: Text('저장하기'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
