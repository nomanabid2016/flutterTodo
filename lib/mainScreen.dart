import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/addTodo.dart';
import 'package:todo_app/widgets/listBuilder.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    loadTodos();
    super.initState();
  }

  List<String> todos = [];

  Future<void> changedText({required String todoText}) async {
    if (todos.contains(todoText)) {
      return showDialog(
          context: context,
          builder: (content) {
            return AlertDialog(
              title: const Text("Already Exists"),
              content: const Text("This todo already exists"),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                )
              ],
            );
          });
    }

    setState(() {
      todos.add(todoText);
    });
    // Obtain shared preferences.
    updateLocalData();
    Navigator.pop(context);
  }

  updateLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an list of strings to 'items' key.
    await prefs.setStringList('todos', todos);
  }

  loadTodos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todos = await prefs.getStringList('todos') ?? [];
    setState(() {});
  }

  showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            child: AddTodo(changedText: changedText),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModal();
          },
          backgroundColor: Colors.blueGrey[900],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.blueGrey[900],
                child: const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Todo App",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                title: Text("About me"),
              ),
              ListTile(
                title: Text("Contactc me"),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("Todo App"),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       showModal();
          //     },
          //     child: const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Icon(Icons.add),
          //     ),
          //   )
          // ],
          centerTitle: true,
        ),
        body: ListBuilderView(
          todos: todos,
          updateLocalData: updateLocalData,
        ));
  }
}
