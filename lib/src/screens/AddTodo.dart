import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String text = "";
  void saveTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var old = prefs.getStringList("text");
    if (old == null) {
      old = new List();
    }
    old.add(text);
    await prefs.setStringList("text", old);
    // Navigator.pushNamed(context, "/");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 10.0,
          children: <Widget>[
            TextField(
              minLines: 2,
              maxLines: 3,
              onChanged: (String tx) {
                setState(() {
                  text = tx;
                });
              },
              decoration: InputDecoration(
                  hintText: "What's next to do?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              width: width,
              height: 40,
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  child: Text("Add Todo"),
                  onPressed: () {
                    saveTodo();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

// class AddTodo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Todo"),
//         backgroundColor: Colors.lightGreen,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               onChanged: (text){

//               },
//               decoration: InputDecoration(
//                   hintText: "What's next to do?",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(40.0))),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
