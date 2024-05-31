import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  Function changedText;
  AddTodo({super.key, required this.changedText});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Add Todo"),
        TextField(
            onSubmitted: (value) {
              if (todoText.text.isNotEmpty) {
                widget.changedText(todoText: todoText.text);
              }
              todoText.text = '';
            },
            autofocus: true,
            controller: todoText,
            decoration: InputDecoration(hintText: "Write your todo here...")),
        ElevatedButton(
            onPressed: () {
              if (todoText.text.isNotEmpty) {
                widget.changedText(todoText: todoText.text);
              }
              todoText.text = '';
            },
            child: Text("Add todo")),
      ],
    );
  }
}
