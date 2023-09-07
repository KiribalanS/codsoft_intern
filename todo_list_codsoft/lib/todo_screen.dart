// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_codsoft/list_of_tasks.dart';
import 'package:todo_list_codsoft/main.dart';
import 'package:todo_list_codsoft/models.dart';
import 'package:todo_list_codsoft/show_completed_tasks.dart';

class Todo extends StatefulWidget {
  Todo({super.key});

  List<dynamic> filteredList = [] + listOfTodo;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  String searchText = "";
  final TextEditingController _controller = TextEditingController();
  bool toShowAllContents = true;

  void filterSearchResults(String query) {
    toShowAllContents = false;
    if (query.isNotEmpty) {
      for (var item in listOfTodo) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          print("object");
          widget.filteredList.clear();
          widget.filteredList.add(item);
          setState(() {
            toShowAllContents = true;
          });
        } else {
          // break;
        }
        print(item.title.toLowerCase().contains(query.toLowerCase()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No tasks found")));
      setState(() {
        widget.filteredList.clear();
        widget.filteredList.addAll(listOfTodo);
      });
      return;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _progress = widget.filteredList[selected].progress;
  //   widget.filteredList[selected]

  int selected = 0;
  // double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    // if (toShowAllContents) {
    //   widget.filteredList.addAll(listOfTodo);
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("No results found!")));
    // }
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListOfTasks(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Task!",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShowCompletedTask(),
                    ),
                  );
                },
                child: Text("View Completed Tasks"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();
                  sp.clear();
                  listOfTodo.clear();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                child: Text("Sign Out"),
              ),
            ),
            Text(
                "(Note : signing out will clear all your tasks and delete your account !!)"),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.manage_search_rounded)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${userModal.userName}',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${listOfTodo.length} tasks pending'),
            SizedBox(
              height: 30,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: AnimatedSearchBar(
                label: "\t\tSearch Something Here",
                controller: _controller,
                labelStyle: TextStyle(
                  fontSize: 16,
                ),
                searchStyle: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                searchDecoration: InputDecoration(
                  // hintText: "Search",
                  alignLabelWithHint: true,
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                onChanged: (val) {
                  setState(() {});
                },
                onFieldSubmitted: (value) {
                  print("value on Field Submitted");
                  filterSearchResults(value);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Ongoing Tasks",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    widget.filteredList.isNotEmpty
                        ? Column(
                            children: [
                              AnimatedPadding(
                                duration: Duration(seconds: 3),
                                curve: Curves.bounceIn,
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Text(
                                              widget.filteredList[selected]
                                                      .progress
                                                      .toString()
                                                      .substring(2, 3) +
                                                  "0 %",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          CircularProgressIndicator(
                                            value: widget.filteredList[selected]
                                                .progress,
                                            color: Colors.orange,
                                            backgroundColor:
                                                Colors.orange.shade50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Target Date \t :" +
                                                widget.filteredList[selected]
                                                    .targetDate,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.filteredList[selected].title,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.filteredList[selected].description,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm_rounded,
                                          size: 25,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            widget.filteredList[selected]
                                                    .startTime +
                                                "\t to \t " +
                                                widget.filteredList[selected]
                                                    .targetTime,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text("Drag to Set how much you finish!"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (details) async {
                                    setState(() {
                                      // Update widget.filteredList[selected]
                                      widget.filteredList[selected].progress +=
                                          details.primaryDelta! /
                                              MediaQuery.of(context).size.width;
                                      widget.filteredList[selected].progress =
                                          widget.filteredList[selected].progress
                                              .clamp(0.0, 1.0);

                                      // Update _progress based on widget.filteredList[selected]

                                      widget.filteredList[selected].progress =
                                          widget
                                              .filteredList[selected].progress;
                                    });
                                    print(listOfTodo[selected]
                                        .progress
                                        .toString());
                                    final _sp =
                                        await SharedPreferences.getInstance();
                                    final spTodo = listOfTodo
                                        .map((e) => e.toJson())
                                        .toList();
                                    _sp.remove(userModal.userName);
                                    _sp.setStringList(
                                      userModal.userName,
                                      spTodo,
                                    );
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: LinearProgressIndicator(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            minHeight: 20,
                                            value: widget.filteredList[selected]
                                                .progress,
                                            color: Colors.orange.shade400,
                                            backgroundColor:
                                                Colors.orange.shade50,
                                          ),
                                        ),
                                        Positioned(
                                          left: widget.filteredList[selected]
                                                      .progress *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8 -
                                              8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade800,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final sp =
                                      await SharedPreferences.getInstance();

                                  listOfFinishedTodo
                                      .add(widget.filteredList[selected]);
                                  final spCompletedTodo = listOfFinishedTodo
                                      .map((e) => e.toJson())
                                      .toList();
                                  await sp.remove("completedTasks");
                                  await sp.setStringList(
                                    "completedTasks",
                                    spCompletedTodo,
                                  );
                                  listOfTodo.removeAt(selected);

                                  await sp.remove(userModal.userName);
                                  final spTodo = listOfTodo
                                      .map((e) => e.toJson())
                                      .toList();
                                  await sp.setStringList(
                                    userModal.userName,
                                    spTodo,
                                  );

                                  setState(() {
                                    widget.filteredList.clear();
                                    widget.filteredList.addAll(listOfTodo);
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Task completed :)\nContinue Rocking!!",
                                    textAlign: TextAlign.center,
                                  )));
                                },
                                child: Text("Finish this Task!!"),
                              ),
                            ],
                          )
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "No tasks added\nCreate a task",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Today's Tasks : "),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "see all",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                ),
                              )),
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          left: 19,
                          right: 480,
                          bottom: 10,
                          top: 10,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                        ),
                        widget.filteredList.isNotEmpty
                            ? SizedBox(
                                // height:
                                // MediaQuery.of(context).size.height * 0.4,
                                child: ListView.builder(
                                  // reverse: true,
                                  primary: false,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => setState(() {
                                        selected = index;
                                      }),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: customCard(
                                              toHighLight: index == selected
                                                  ? true
                                                  : false,
                                              description: widget
                                                  .filteredList[index]
                                                  .description,
                                              time: widget.filteredList[index]
                                                  .targetTime,
                                              title: widget
                                                  .filteredList[index].title,
                                              index: index,
                                              context: context,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              listOfTodo.removeAt(index);

                                              widget.filteredList.clear();
                                              widget.filteredList
                                                  .addAll(listOfTodo);
                                              setState(() {
                                                selected =
                                                    0; // got some bugs...need to clear the error!!
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Task Deleted Successfully ",
                                                ),
                                              ));
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: widget.filteredList.length,
                                ),
                              )
                            : SizedBox(
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.filteredList.clear();
                                        widget.filteredList.addAll(listOfTodo);
                                      });
                                    },
                                    child: Text("Reload data")),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customCard({title, description, time, index, context, toHighLight}) {
  // print(time);
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          maxRadius: 12,
          minRadius: 9,
          child: CircleAvatar(
            minRadius: 6,
            maxRadius: 9,
            backgroundColor: toHighLight ? Colors.amber : Colors.white,
          ),
        ),
      ),
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
