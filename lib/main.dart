import 'package:flutter/material.dart';
import 'package:todo_flutter/src/screens/Home.dart';
import './src/screens/AddTodo.dart';

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      routes: {
        "/": (context) => Home(),
        "/add": (context) => AddTodo(),
      },
    );
  }
}

void main() async {
  runApp(Router());
}
