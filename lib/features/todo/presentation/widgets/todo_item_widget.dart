import 'package:flutter/material.dart';
import 'package:flutter_pray_app/features/todo/models/todo_item.dart';
import 'package:flutter_pray_app/features/todo/presentation/widgets/edit_todo_dialog.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final VoidCallback onRemove;
  final ValueChanged<String> onEdit;

  const ToDoItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Gölge yüksekliği
      margin: const EdgeInsets.symmetric(vertical: 1.0), // Kartlar arasındaki boşluk
      color: Colors.white, // Kart arka plan rengi
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Köşeleri yuvarlatma
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        title: Text(item.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final updatedTitle = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => EditToDoDialog(
                    initialTitle: item.title,
                    onUpdate: (newTitle) {
                      onEdit(newTitle);
                    },
                  ),
                );
                if (updatedTitle != null && updatedTitle.isNotEmpty) {
                  onEdit(updatedTitle);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
