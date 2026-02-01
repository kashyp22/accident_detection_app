import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: user_view_complaint(),
    );
  }
}


class user_view_complaint extends StatefulWidget {
  const user_view_complaint({super.key});

  @override
  State<user_view_complaint> createState() => _user_view_complaintState();
}

class _user_view_complaintState extends State<user_view_complaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View Complaint"),
        ),
        body: Center(
          child: Text("Home"),
        )
    );
  }
}
