import 'package:flutter/material.dart';

class EditToDoDialog extends StatefulWidget {
  final String initialTitle;
  final ValueChanged<String> onUpdate;

  const EditToDoDialog({
    super.key,
    required this.initialTitle,
    required this.onUpdate,
  });

  @override
  _EditToDoDialogState createState() => _EditToDoDialogState();
}

class _EditToDoDialogState extends State<EditToDoDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit To-Do'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Enter new task',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onUpdate(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
