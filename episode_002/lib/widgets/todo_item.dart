import 'package:at_client/at_client.dart';
import 'package:at_commons/at_commons.dart';
import 'package:episode_002/models/todo.dart';
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

  void share(String shareWith) {
    AtClient atClient = AtClientManager.getInstance().atClient;
    AtKey k = widget.todo.key;
    k.sharedWith = shareWith;
    atClient.put(k, todo);
  }

  @override
  void initState() {
    super.initState();
    todo = widget.todo.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            showDialog(context: context, builder: (_) => ShareDialog(share));
          },
        )
      ],
    );
  }
}
