// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_codsoft/models.dart';
import 'package:todo_list_codsoft/todo_screen.dart';

class ListOfTasks extends StatelessWidget {
  ListOfTasks({super.key});

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  saveTaskToSP(TodoModal todo) async {
    final SharedPreferences _sp = await SharedPreferences.getInstance();

    final spTodo = listOfTodo.map((e) => e.toJson()).toList();
    _sp.setStringList(
      userModal.userName,
      spTodo,
    );
  }

  _showDatePicker(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024, DateTime.january));
    if (pickedDate != null) {
      print(pickedDate);
      return pickedDate.toString();
      //perform required action
    } else {
      return DateFormat.yMd(DateTime.now().add(Duration(days: 1))).toString();
    }
  }

  Future<String> _showTimePicker(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      print(pickedTime.format(context));

      return pickedTime.toString();
    } else {
      print("Time is not selected");
      return TimeOfDay(hour: 2, minute: 30).format(context);
    }
  }

  String targetDate =
      DateFormat.yMd().format(DateTime.now().add(Duration(days: 1))).toString();
  String targetTime = "Default";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: Text("Create a task to do!"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText("Create task:"),
                customText("Enter Task title:"),
                customTextField("Title of your task", _titleController),
                customText("Enter Task Description: "),
                customTextField(
                    "Description of the task (optional)", _descController),
                Row(
                  children: [
                    customText("Click the icon to Select the target time: "),
                    IconButton(
                      onPressed: () async {
                        targetTime = await _showTimePicker(context);
                      },
                      icon: Icon(
                        Icons.timer,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    customText("Click the icon to Select the target date: "),
                    IconButton(
                      onPressed: () async {
                        targetDate = await _showDatePicker(context);
                      },
                      icon: Icon(
                        Icons.calendar_month_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_titleController.text != "") {
                TodoModal newTodo = TodoModal(
                  startTime: TimeOfDay.now().format(context),
                  startDate: DateFormat.yMd().format(DateTime.now()).toString(),
                  title: _titleController.text,
                  description: _descController.text == ""
                      ? "No description added"
                      : _descController.text,
                  targetDate: targetDate,
                  targetTime: targetTime == "Default"
                      ? TimeOfDay(hour: 2, minute: 30).format(context)
                      : targetTime,
                );

                listOfTodo.add(newTodo);
                await saveTaskToSP(newTodo);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Todo(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill the title "),
                  ),
                );
              }
            },
            child: customText(
              "Create task!",
            ),
          ),
          Text("(or)"),
          SafeArea(
            top: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.40,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    customText(
                      "Double Tap on a Tile \nSelect a task!",
                    ),
                    customCard(
                      title: "Nptel assignment",
                      description: "attend the assignment for week 3",
                      time: "6:30 PM",
                      context: context,
                    ),
                    customCard(
                      title: "SE assignment",
                      description: "Write the assignment for atleast 5 pages",
                      time: "8:00 PM",
                      context: context,
                    ),
                    customCard(
                      title: "Mobile Recharge",
                      description: "Recharge for 395 plan ",
                      time: "12:00 PM",
                      context: context,
                    ),
                    customCard(
                      title: "Fiber Recharge",
                      description: "Recharge for 580 plan ",
                      time: "7:00 AM",
                      context: context,
                    ),
                    customCard(
                      title: "Seminar",
                      description: "Take seminar for second years",
                      time: "10:00 AM",
                      context: context,
                    ),
                    customCard(
                      title: "class test",
                      description: "Write the class test for english",
                      time: "1:30 PM",
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customCard({title, description, time, context}) {
    return GestureDetector(
      onDoubleTap: () async {
        TodoModal newTodo = TodoModal(
          startTime: TimeOfDay.now().format(context),
          startDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
          title: title,
          description: description,
          targetDate: targetDate,
          targetTime: time,
        );

        listOfTodo.add(newTodo);
        await saveTaskToSP(newTodo);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Todo(),
          ),
        );
      },
      child: Row(
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
      ),
    );
  }

  Widget customTextField(hint, controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget customText(content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
