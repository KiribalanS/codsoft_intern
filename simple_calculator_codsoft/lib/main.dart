// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "";
  Map<String, String> equation = {
    "left_operand": "",
    "right_operand": "",
    "operator": "",
  };
  final List operators = ["+", "-", "*", "/", "%"];
  final List modifiers = ["AC", "⌫", "="];
  final _controller = TextEditingController();
  String output = "";
  String calculateExpression() {
    String result = "";
    switch (equation["operator"]) {
      case "+":
        result = add(equation["left_operand"], equation["right_operand"]);
        break;
      case "-":
        result = subtract(equation["left_operand"], equation["right_operand"]);
        break;
      case "*":
        result = multiply(equation["left_operand"], equation["right_operand"]);
        break;
      case "/":
        result = divide(equation["left_operand"], equation["right_operand"]);
        break;
      case "%":
        result = modulus(equation["left_operand"], equation["right_operand"]);
        break;
    }
    return result;
  }

  updateNumber(number) {
    if (number == "=" &&
        equation["left_operand"] != "" &&
        equation["right_operand"] != "" &&
        equation["operator"] != "") {
      setState(() {
        output = calculateExpression();
      });
      return;
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Enter the data properly")));
      //// got some issues, need to debug it
    }
    if (number == "⌫" && value.isNotEmpty && _controller.text.isNotEmpty) {
      _controller.text =
          _controller.text.substring(0, _controller.text.length - 1);
      value = value.substring(0, value.length - 1);
      return;
    } else if (number == "⌫" && value.isEmpty && _controller.text.isEmpty) {
      return;
    }
    String temp;
    if (!modifiers.contains(number)) {
      temp = value + number;
      value = temp;
    }
    if (number == "AC") {
      _controller.text = "";
      equation["operator"] = "";
      equation["left_operand"] = "";
      equation["right_operand"] = "";

      value = "";
      output = "";
      return;
    } else if (operators.contains(number)) {
      equation["operator"] = number;
      value = "";
    } else if (equation["operator"] == "") {
      equation["left_operand"] = value;
    } else if (equation["operator"] != "") {
      equation["right_operand"] = value;
    }
    _controller.text = equation["left_operand"].toString() +
        equation["operator"].toString() +
        equation["right_operand"].toString();
  }

  final List buttonNames = [
    {
      "ButtonName": "AC",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "%",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "⌫",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "/",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "7",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "8",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "9",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "*",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "4",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "5",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "6",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "-",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "1",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "2",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "3",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "+",
      "ButtonColor": Colors.grey.shade600,
    },
    {
      "ButtonName": "00",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "0",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": ".",
      "ButtonColor": Colors.grey.shade900,
    },
    {
      "ButtonName": "=",
      "ButtonColor": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Simple Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: _controller,
              cursorHeight: 50,
              cursorWidth: 3,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
              keyboardType: TextInputType.none,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                output.toString(),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 400,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2,
              ),
              itemCount: buttonNames.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    updateNumber(buttonNames[index]["ButtonName"].toString());
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
                      shape: CircleBorder(eccentricity: 0),
                      color: buttonNames[index]["ButtonColor"],
                      child: CircleAvatar(
                        backgroundColor: buttonNames[index]["ButtonColor"],
                        child: Text(
                          buttonNames[index]["ButtonName"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String add(l, r) {
  int a = int.parse(l);
  int b = int.parse(r);
  return (a + b).toString();
}

String subtract(l, r) {
  int a = int.parse(l);
  int b = int.parse(r);
  return (a - b).toString();
}

String multiply(l, r) {
  int a = int.parse(l);
  int b = int.parse(r);
  return (a * b).toString();
}

String divide(l, r) {
  int a = int.parse(l);
  int b = int.parse(r);
  return (a / b).toString();
}

String modulus(l, r) {
  int a = int.parse(l);
  int b = int.parse(r);
  return (a % b).toString();
}
