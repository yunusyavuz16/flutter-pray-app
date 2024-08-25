import 'package:flutter/material.dart';
import 'package:flutter_pray_app/features/todo/models/todo_item.dart';
import 'package:flutter_pray_app/features/todo/presentation/widgets/todo_item_widget.dart';
import 'package:flutter_pray_app/features/todo/presentation/widgets/add_todo_dialog.dart';
import 'package:flutter_pray_app/features/todo/presentation/widgets/custom_search_bar.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final List<ToDoItem> _toDoItems = [];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  void _addToDoItem(String task) {
    setState(() {
      _toDoItems.add(ToDoItem(title: task));
    });
  }

  void _removeToDoItem(int index) {
    setState(() {
      _toDoItems.removeAt(index);
    });
  }

  void _editToDoItem(int index, String newTitle) {
    setState(() {
      _toDoItems[index].title = newTitle;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List<ToDoItem> get _filteredToDoItems {
    if (_searchQuery.isEmpty) {
      return _toDoItems;
    }
    return _toDoItems
        .where((item) => item.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.25),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          CustomSearchBar(
            onSearchChanged: _onSearchChanged,
            controller: _searchController,
          ),
          Expanded(
            child: _buildToDoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // İkon rengi
        onPressed: () async {
          final newTask = await showDialog<String>(
            context: context,
            builder: (BuildContext context) => const AddToDoDialog(),
          );
          if (newTask != null && newTask.isNotEmpty) {
            _addToDoItem(newTask);
          }
        },
        child: const Icon(Icons.add),

      ),
    );
  }

  Widget _buildToDoList() {
    return ListView.builder(
      itemCount: _filteredToDoItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ToDoItemWidget(
            item: _filteredToDoItems[index],
            onRemove: () => _removeToDoItem(index),
            onEdit: (newTitle) => _editToDoItem(index, newTitle),
          ),
        );
      },
    );
  }
}
