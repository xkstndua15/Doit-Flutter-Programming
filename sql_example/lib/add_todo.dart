import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  const AddTodoApp({Key? key, required this.db}) : super(key: key);

  @override
  _AddTodoAppState createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  TextEditingController? _titleController;
  TextEditingController? _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: SizedBox(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: '제목'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(labelText: '할일'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Todo todo = Todo(
                        title: _titleController!.value.text,
                        content: _contentController!.value.text,
                        active: 0);
                    Navigator.of(context).pop(todo);
                  },
                  child: Text('저장하기'))
            ],
          ),
        ),
      ),
    );
  }
}
