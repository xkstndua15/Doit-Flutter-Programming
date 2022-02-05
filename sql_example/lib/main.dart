import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'add_todo.dart';
import 'todo.dart';
import 'clear_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Database> initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), 'todo_database.db'),
        onCreate: (db, version) {
      return db
          .execute("CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "title TEXT, content TEXT, active INTEGER)");
    }, version: 1);
  }

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(
              db: database,
            ),
        '/add': (context) => AddTodoApp(db: database),
        '/clear': (context) => ClearListApp(database: database)
      },
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  const DatabaseApp({Key? key, required this.db}) : super(key: key);

  @override
  _DatabaseAppState createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=0');

    return List.generate(maps.length, (i) {
      int active = maps[i]['active'] == 1 ? 1 : 0;
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          active: active,
          id: maps[i]['id']);
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: Text(
                '완료한 일',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SizedBox(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          onTap: () async {
                            TextEditingController controller =
                                TextEditingController(text: todo.content);
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: TextField(
                                      controller: controller,
                                      keyboardType: TextInputType.text,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              todo.active == 1
                                                  ? todo.active = 0
                                                  : todo.active = 1;
                                              todo.content =
                                                  controller.value.text;
                                            });
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: Text('예')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: Text('아니요'))
                                    ],
                                  );
                                });
                            _updateTodo(result);
                          },
                          onLongPress: () async {
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('${todo.id} : ${todo.title}'),
                                    content: Text('${todo.content}를 삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(todo);
                                          },
                                          child: Text('예')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('아니요'))
                                    ],
                                  );
                                });
                            _deleteTodo(result);
                          },
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: SizedBox(
                            child: Column(
                              children: <Widget>[
                                Text(todo.content!),
                                Text(
                                    '체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                                Container(height: 1, color: Colors.blue)
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  } else {
                    return Text('No Data');
                  }
              }
            },
            future: todoList!,
          ),
        ),
      ),
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              _allUpdate();
            },
            heroTag: null,
            child: Icon(Icons.update),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
  }
}
