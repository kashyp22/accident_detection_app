// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void main(){
//   runApp(App());
// }
//
//
// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: user_send_sendcomplaint(),
//     );
//   }
// }
//
//
// class user_send_sendcomplaint extends StatefulWidget {
//   const user_send_sendcomplaint({super.key});
//
//   @override
//   State<user_send_sendcomplaint> createState() => _user_send_sendcomplaintState();
// }
//
// class _user_send_sendcomplaintState extends State<user_send_sendcomplaint> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Send sendcomplaint"),
//         ),
//         body: Center(
//           child: Text("Home"),
//         )
//     );
//   }
// }

import 'dart:convert';

import 'package:ad_app_tm/user/user_home.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class sendcomplaint extends StatefulWidget {
  @override
  _sendcomplaintState createState() => _sendcomplaintState();
}

class _sendcomplaintState extends State<sendcomplaint> {
// Lists to store sendcomplaints and their replies
  List<String> sendcomplaints = [];
  List<String> replies = [];


  List<String> ccid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> reply_ = <String>[];

  List<String> sendcomplaint_ = <String>[];
  _sendcomplaintState(){
    load();
  }
  Future<void> load() async {
    List<String> ccid = <String>[];
    List<String> date = <String>[];
    List<String> reply = <String>[];
    List<String> sendcomplaint = <String>[];


    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "/viewcomplaintuser/";
      print(url);
      var data = await http.post(Uri.parse(url), body: {
        'lid': lid
      });

      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];

      print(arr);

      print(arr.length);

      // List<String> schid_ = <String>[];
      // List<String> date_ = <String>[];
      // List<String> type_ = <String>[];

      for (int i = 0; i < arr.length; i++) {
        ccid.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        reply.add(arr[i]['reply'].toString());
        sendcomplaint.add(arr[i]['complaint'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        reply_ = reply;
        sendcomplaint_ = sendcomplaint;
      });
      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sendcomplaints"),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: ccid_.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              onTap: () {


              },
              title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [


                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [

                            SizedBox(height: 16,),
                            Row(

                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Flexible(flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text(" Date")])),
                                Flexible(flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text(date_[index])])),

                                // Text("Place"),
                                // Text(place_[index])
                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(

                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Flexible(flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text("sendcomplaint")])),
                                Flexible(flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(
                                        children: [Text(sendcomplaint_[index])])),

                                // Text("Place"),
                                // Text(place_[index])
                              ],
                            ),
                            SizedBox(height: 16,), Row(

                              children: [
                                SizedBox(
                                  width: 10,
                                ),

                                Flexible(flex: 2,
                                    fit: FlexFit.loose,
                                    child: Row(children: [Text("Reply")])),
                                Flexible(flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(
                                        children: [Text(reply_[index])])),

                                // Text("Place"),
                                // Text(place_[index])
                              ],
                            ),


                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ),


                  ],
                ),
              )


          );
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
// Navigate to the New sendcomplaint page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsendcomplaintPage(),
            ),
          ).then((newsendcomplaint) {
// Add the new sendcomplaint to the list (if provided)
            if (newsendcomplaint != null) {
              setState(() {
                sendcomplaints.add(newsendcomplaint);
                replies.add("Admin Reply for New sendcomplaint");
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewsendcomplaintPage extends StatefulWidget {
  @override
  _NewsendcomplaintPageState createState() => _NewsendcomplaintPageState();
}

class _NewsendcomplaintPageState extends State<NewsendcomplaintPage> {
  final TextEditingController _sendcomplaintController = TextEditingController();

  @override
  void dispose() {
    _sendcomplaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write a New sendcomplaint"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sendcomplaintController,
              decoration: InputDecoration(
                hintText: "Enter your sendcomplaint...",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final sh = await SharedPreferences.getInstance();
                String sendcomplaint = _sendcomplaintController.text.toString();
                // String Passwd=passwordController.text.toString();
                String url = sh.getString("url").toString();
                String lid = sh.getString("lid").toString();
                print("okkkkkkkkkkkkkkkkk");
                var data = await http.post(
                    Uri.parse(url + "/sendcomplaintuser/"),
                    body: {'complaint': sendcomplaint,
                      'lid': lid,

                    });
                var jasondata = json.decode(data.body);
                String status = jasondata['task'].toString();
                if (status == "ok") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserHome()));
                }
                else {
                  print("error");
                }
              },
              child: Text("Submit sendcomplaint"),
            ),
          ],
        ),
      ),
    );
  }
}
