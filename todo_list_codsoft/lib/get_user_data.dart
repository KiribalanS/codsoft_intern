// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_codsoft/list_of_tasks.dart';
import 'package:todo_list_codsoft/models.dart';

class GetUserData extends StatelessWidget {
  GetUserData({super.key});

  final _nameController = TextEditingController();
  final _professionController = TextEditingController();

  saveToSP() async {
    final SharedPreferences _sp = await SharedPreferences.getInstance();
    await _sp.setBool("isSignedIn", true);
    await _sp.setString("userName", _nameController.text);
    await _sp.setString("profession", _professionController.text);
  }

  // saveUserDataToSP() async {
  //   final SharedPreferences _sp = await SharedPreferences.getInstance();
  //   await _sp.setString("userName", _nameController.text);
  //   await _sp.setString("profession", _professionController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 120,
            left: 120,
            right: 120,
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter You Name:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                customTextField(
                  "Ex : Aakash",
                  _nameController,
                ),
                Text(
                  "Enter your Profession:",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                customTextField(
                  "Ex : Student",
                  _professionController,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Card(
        color: Colors.purple,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 12,
            bottom: 12,
          ),
          child: IconButton(
            color: Colors.white,
            highlightColor: Colors.amber,
            onPressed: () async {
              if (_nameController.text != "" &&
                  _professionController.text != "") {
                userModal.userName = _nameController.text;
                userModal.userProfession = _professionController.text;
                await saveToSP();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ListOfTasks(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please fill all the fields"),
                  ),
                );
              }
            },
            icon: Icon(
              Icons.navigate_next_outlined,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

Widget customTextField(hint, controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
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
    ),
  );
}
