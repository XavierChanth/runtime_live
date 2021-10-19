import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog(this.callback, {Key? key}) : super(key: key);
  final void Function() callback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to delete this?'),
      actions: [
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
            child: const Text('Delete')),
      ],
    );
  }
}
