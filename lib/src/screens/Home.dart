import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _loadTodo();
  }

  var list;
  void _loadTodo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ls = prefs.getStringList("text");
    if (ls != null) {
      ls = ls.reversed.toList();
    }
    setState(() {
      list = ls;
    });
  }

  void _deleteTodo(text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Do you wanna delete it?"),
            content: Text("This cannot be undone."),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                onPressed: () {
                  _deleteFinally(text);
                },
                child: Text("Yes"),
              )
            ],
          );
        });
  }

  void _deleteFinally(text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List oldList = prefs.getStringList("text");
    oldList.remove(text);
    list.remove(text);
    setState(() {
      list = list;
    });
    prefs.remove(text);
    prefs.setStringList("text", oldList);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RaisedButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        color: Colors.lightGreen,
        onPressed: () async {
          await Navigator.pushNamed(context, "/add");
          _loadTodo();
        },
        padding: EdgeInsets.all(10),
        shape: CircleBorder(),
      ),
      appBar: AppBar(
        title: Text("To Do App"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
          //modal part
          //     child: Dialog(
          //   elevation: 100.0,
          //   backgroundColor: Colors.white70,
          //   child: Container(
          //     height: 200,
          //     padding: EdgeInsets.all(10),
          //     child: Align(
          //       alignment: Alignment.center,
          //       child: Text("Hello",
          //           style: TextStyle(
          //             color: Colors.green,
          //           )),
          //     ),
          //   ),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // )
          child: list != null && list.length > 0
              ? ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text("${list[index]}",
                            style: GoogleFonts.sriracha()),
                        trailing: RaisedButton(
                          onPressed: () {
                            _deleteTodo(list[index]);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ));
                  })
              : Center(
                  child: Text(
                    "Nothing to do!",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                )),
    );
  }
}
