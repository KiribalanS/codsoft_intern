import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_codsoft/models.dart';

class ShowCompletedTask extends StatefulWidget {
  const ShowCompletedTask({super.key});

  @override
  State<ShowCompletedTask> createState() => _ShowCompletedTaskState();
}

class _ShowCompletedTaskState extends State<ShowCompletedTask> {
  @override
  void initState() {
    super.initState();
  }

  getCompletedTaskFromSP() async {
    final sp = await SharedPreferences.getInstance();
    final comp = sp.getStringList("completedTasks");
    if (comp != null) {
      final list =
          comp.map((todoString) => TodoModal.fromJson(todoString)).toList();
      listOfFinishedTodo.clear();
      listOfFinishedTodo = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed tasks"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: listOfFinishedTodo.length,
          itemBuilder: (BuildContext context, int index) {
            return customCard(
              context: context,
              description: listOfFinishedTodo[index].description,
              time: listOfFinishedTodo[index].targetDate,
              title: listOfFinishedTodo[index].title,
            );
          },
        ),
      ),
    );
  }
}

Widget customCard({title, description, time, context}) {
  return Row(
    children: [
      Expanded(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          time,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
      ),
    ],
  );
}
