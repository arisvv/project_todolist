import 'package:flutter/material.dart';
import 'package:project_todolist/database_helper.dart';
import 'package:project_todolist/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  TextEditingController _namaCtrl = TextEditingController();
  TextEditingController _deskripsiCtrl = TextEditingController();
  List<Todo> todoList = [];

  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() async {
    final todos = await dbHelper.getAllTodos();
    setState(() {
      todoList = todos;
    });
  }

  void addItem() async {
    await dbHelper.addTodo(Todo(_namaCtrl.text, _deskripsiCtrl.text));
    //todoList.add(Todo(_namaCtrl.text, _deskripsiCtrl.text));
    refreshList();

    _namaCtrl.text = ' ';
    _deskripsiCtrl.text = ' ';
  }

  void updateItem(int index, bool done) {
    todoList[index].done = done;
    refreshList();
  }

  void deleteItem(int index) {
    todoList.removeAt(index);
    refreshList();
  }

  void tampilForm() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.all(20),
              title: Text("Tambah Todo"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Tutup")),
                ElevatedButton(
                    onPressed: () {
                      addItem();
                      Navigator.pop(context);
                    },
                    child: Text('Tambah'))
              ],
              content: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    TextField(
                      controller: _namaCtrl,
                      decoration: InputDecoration(hintText: 'Nama Todo'),
                    ),
                    TextField(
                      controller: _deskripsiCtrl,
                      decoration:
                          InputDecoration(hintText: 'Deskripsi Pekerjaan'),
                    )
                  ])),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Todo List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tampilForm();
        },
        child: Icon(Icons.add_box),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: todoList[index].done
                        ? IconButton(
                            icon: const Icon(Icons.check_circle),
                            onPressed: () {
                              updateItem(index, !todoList[index].done);
                            },
                          )
                        : IconButton(
                            icon: const Icon(Icons.radio_button_unchecked),
                            onPressed: () {
                              updateItem(index, !todoList[index].done);
                            },
                          ),
                    title: Text(todoList[index].nama),
                    subtitle: Text(todoList[index].deskripsi),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteItem(index);
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
