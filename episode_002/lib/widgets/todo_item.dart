import 'package:at_client/at_client.dart';
import 'package:at_commons/at_commons.dart';
import 'package:episode_002/models/todo.dart';
import 'package:episode_002/widgets/delete_dialog.dart';
import 'package:episode_002/widgets/share_dialog.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(this.todo, {Key? key}) : super(key: key);
  final MapEntry<AtKey, Todo> todo;
  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late Todo todo;
  bool deleted = false;

  void share(String shareWith) {
    AtClient atClient = AtClientManager.getInstance().atClient;
    AtKey k = widget.todo.key;
    k.sharedWith = shareWith;
    atClient.put(k, todo);
  }

  void delete() {
    AtClient atClient = AtClientManager.getInstance().atClient;
    atClient.delete(widget.todo.key);
    setState(() {
      deleted = true;
    });
  }

  @override
  void initState() {
    super.initState();
    todo = widget.todo.value;
  }

  @override
  Widget build(BuildContext context) {
    if (deleted) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: todo.checked,
              onChanged: (checked) {
                setState(() {
                  todo.checked = checked ?? false;
                });
              },
            ),
            Text(todo.value),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => ShareDialog(share));
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => DeleteDialog(delete));
              },
            )
          ],
        )
      ],
    );
  }
}
