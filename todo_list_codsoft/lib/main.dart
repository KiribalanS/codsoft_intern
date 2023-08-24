// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list_codsoft/get_user_data.dart';
import 'package:todo_list_codsoft/models.dart';
import 'package:todo_list_codsoft/todo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSignedIn = false; // Initialize with a default value

  @override
  void initState() {
    checkSignIn();
    super.initState();
  }

  checkSignIn() async {
    final SharedPreferences _sp = await SharedPreferences.getInstance();
    bool updatedIsSignedIn = _sp.getBool("isSignedIn") ?? false;

    if (updatedIsSignedIn) {
      userModal.userName = _sp.getString("userName") ?? "No UserName found";
      userModal.userProfession =
          _sp.getString("profession") ?? "No Profession found";

      final sharedPreferences = await SharedPreferences.getInstance();
      final spTodo = sharedPreferences.getStringList(userModal.userName);

      final list =
          spTodo!.map((todoString) => TodoModal.fromJson(todoString)).toList();
      listOfTodo.addAll(list);
      // print(list);
      // final single = sharedPreferences.getString("late");
      // print(TodoModal.fromJson(single!));
    }

    setState(() {
      isSignedIn = updatedIsSignedIn;
    });

    print(isSignedIn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isSignedIn ? Todo() : Todo(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/images/intro_todo.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 80,
            right: 20,
            left: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "Manage Your\nEveryday task list",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 30),
                  child: Text(
                    '''\t\tCODSOFT is a vibrant and diverse community that brings together individuals with similar objectives and ultimate goals.''',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.amber,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => GetUserData(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 65,
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
