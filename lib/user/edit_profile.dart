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
      home: user_edit_profile(),
    );
  }
}


class user_edit_profile extends StatefulWidget {
  const user_edit_profile({super.key});

  @override
  State<user_edit_profile> createState() => _user_edit_profileState();
}

class _user_edit_profileState extends State<user_edit_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Center(
          child: Text("Home"),
        )
    );
  }
}
