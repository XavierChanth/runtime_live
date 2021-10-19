import 'package:flutter/material.dart';

class ShareDialog extends StatefulWidget {
  const ShareDialog(this.callback, {Key? key}) : super(key: key);
  final void Function(String) callback;
  @override
  _ShareDialogState createState() => _ShareDialogState();
}

class _ShareDialogState extends State<ShareDialog> {
  TextEditingController controller = TextEditingController();

  void share() {
    if (controller.text.isEmpty) return;
    String text = controller.text.trim();
    if (text[0] != '@') text = '@' + text;
    print(text);
    widget.callback(text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share with...'),
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
            share();
            Navigator.of(context).pop();
          },
          child: const Text('Share'),
        )
      ],
    );
  }
}
