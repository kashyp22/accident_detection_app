import 'dart:convert';

import 'package:ad_app_tm/ambulance/send_complaint.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class complaint extends StatefulWidget {
  @override
  _complaintState createState() => _complaintState();
}

class _complaintState extends State<complaint> {
// Lists to store complaints and their replies
  List<String> complaints = [];
  List<String> replies = [];


  List<String> ccid_ = <String>[];
  List<String> date_ = <String>[];
  List<String> reply_ = <String>[];

  List<String> complaint_ = <String>[];
  _complaintState(){
    load();
  }
  Future<void> load() async {
    List<String> ccid = <String>[];
    List<String> date = <String>[];
    List<String> reply = <String>[];
    List<String> complaint = <String>[];


    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "/ambulance_view_complaint/";
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
        complaint.add(arr[i]['complaint'].toString());
      }
      setState(() {
        ccid_ = ccid;
        date_ = date;
        reply_ = reply;
        complaint_ = complaint;
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
        title: Text("Complaints"),
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
                                    child: Row(children: [Text("Complaint")])),
                                Flexible(flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(
                                        children: [Text(complaint_[index])])),

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
// Navigate to the New Complaint page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewComplaintPage(),
            ),
          ).then((newComplaint) {
// Add the new complaint to the list (if provided)
            if (newComplaint != null) {
              setState(() {
                complaints.add(newComplaint);
                replies.add("Admin Reply for New Complaint");
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
