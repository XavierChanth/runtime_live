import 'package:episode_002/models/todo.dart';
import 'package:flutter/material.dart';

class AddDialog extends StatefulWidget {
  const AddDialog(this.callback, {Key? key}) : super(key: key);
  final void Function(Todo) callback;
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String item = '';
  TextEditingController controller = TextEditingController();

  void createTodo() {
    if (controller.text.isEmpty) return;
    Todo t = Todo(controller.text);
    widget.callback(t);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Todo'),
      content: TextField(
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            createTodo();
            Navigator.of(context).pop();
          },
          child: const Text('Add!'),
        )
      ],
    );
  }
}
