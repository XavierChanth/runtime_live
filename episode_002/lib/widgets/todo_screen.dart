import 'package:at_client/at_client.dart';
import 'package:at_commons/at_commons.dart';
import 'package:episode_002/widgets/todo_item.dart';
import 'package:episode_002/widgets/add_dialog.dart';
import 'package:flutter/material.dart';

import 'package:episode_002/models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  Map<AtKey, Todo> todos = {};

  AtClient atClient = AtClientManager.getInstance().atClient;
  late String atsign;
  @override
  void initState() {
    super.initState();
    loadTodos();
    atsign = atClient.getCurrentAtSign()!;
  }

  void loadTodos() async {
    atClient.getAtKeys(regex: 'item-').then((keys) {
      for (AtKey key in keys) {
        atClient.get(key).then((value) {
          setState(() {
            todos[key] = Todo.fromJson(value.value);
          });
        });
      }
    });
  }

  void addTodo(Todo t) {
    AtKey key = AtKey()
      ..key = 'item-${DateTime.now().millisecondsSinceEpoch.toString()}'
      ..sharedWith = atsign
      ..sharedBy = atsign;
    setState(() {
      todos.addAll({key: t});
    });
    atClient.put(key, t.toJson());
  }

  @override
  Widget build(BuildContext context) {
    var items = todos.entries.toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddDialog(addTodo);
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoItem(items[index]);
        },
      ),
    );
  }
}
