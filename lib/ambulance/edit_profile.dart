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
      home: ambulance_edit_profile(),
    );
  }
}


class ambulance_edit_profile extends StatefulWidget {
  const ambulance_edit_profile({super.key});

  @override
  State<ambulance_edit_profile> createState() => _ambulance_edit_profileState();
}

class _ambulance_edit_profileState extends State<ambulance_edit_profile> {
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
