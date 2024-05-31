import 'package:flutter/material.dart';

class ListBuilderView extends StatefulWidget {
  List<String> todos;
  void Function() updateLocalData;
  ListBuilderView(
      {super.key, required this.todos, required this.updateLocalData});

  @override
  State<ListBuilderView> createState() => _ListBuilderViewState();
}

class _ListBuilderViewState extends State<ListBuilderView> {
  @override
  Widget build(BuildContext context) {
    return widget.todos.isEmpty
        ? Center(
            child: Text("No todo found"),
          )
        : ListView.builder(
            itemCount: widget.todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check),
                      )
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.todos.removeAt(index);
                  });
                  widget.updateLocalData();
                },
                child: ListTile(
                  title: Text(widget.todos[index]),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text("Mark as done"),
                            onPressed: () {
                              setState(() {
                                widget.todos.removeAt(index);
                              });
                              widget.updateLocalData();
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
  }
}
