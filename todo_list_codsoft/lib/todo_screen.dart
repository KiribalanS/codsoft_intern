// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_codsoft/list_of_tasks.dart';
import 'package:todo_list_codsoft/main.dart';
import 'package:todo_list_codsoft/models.dart';

class Todo extends StatefulWidget {
  Todo({super.key});

  List<dynamic> filteredList = [] + listOfTodo;

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  String searchText = "";
  TextEditingController _controller = TextEditingController(text: "");
  bool toShowAllContents = true;

  void filterSearchResults(String query) {
    toShowAllContents = false;
    if (query.isNotEmpty) {
      for (var item in listOfTodo) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          widget.filteredList.clear();
          widget.filteredList.add(item);
          setState(() {});
        }
        print(item.title + "=" + query);
      }
      return;
    } else if (query == "") {
      widget.filteredList.addAll(listOfTodo);
      setState(() {});
    } else {
      widget.filteredList.clear();
      //show no results found.
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (toShowAllContents) {
    //   widget.filteredList.addAll(listOfTodo);
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
                "(Note : signing out will clear all your tasks and delete your account !!)")
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
                  hintText: "Search",
                  alignLabelWithHint: true,
                  fillColor: Colors.black,
                  focusColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                closeIcon: Icon(
                  Icons.close,
                ),
                onChanged: (value) {
                  print("value on Change" + value);
                  filterSearchResults(value);
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
                        "Ongoing Taks",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    AnimatedPadding(
                      duration: Duration(seconds: 3),
                      curve: Curves.bounceIn,
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Stack(
                              children: [
                                Center(
                                  child: Text(
                                    "54%",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                CircularProgressIndicator(
                                  value: 0.54,
                                  color: Colors.orange,
                                  backgroundColor: Colors.orange.shade50,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("6 days left"),
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
                            "To Do app design",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
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
                                  "10:00 AM to 12:30 PM",
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: customCard(
                                      description: widget
                                          .filteredList[index].description,
                                      time:
                                          widget.filteredList[index].targetTime,
                                      title: widget.filteredList[index].title,
                                      index: index,
                                      context: context,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        listOfTodo.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Congratulations :>\n\tKeep going on",
                                        ),
                                      ));
                                    },
                                    icon: Icon(Icons.done),
                                  ),
                                ],
                              );
                            },
                            itemCount: widget.filteredList.length,
                          ),
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

Widget customCard({title, description, time, index, context}) {
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
            backgroundColor: Colors.white,
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
