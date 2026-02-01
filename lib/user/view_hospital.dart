import 'dart:convert';

import 'package:ad_app_tm/ambulance/send_complaint.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class nearesthospital extends StatefulWidget {
  @override
  _nearesthospitalState createState() => _nearesthospitalState();
}

class _nearesthospitalState extends State<nearesthospital> {
// Lists to store complaints and their replies
  List<String> name_ = [];
  List<String> id_ = [];
  List<String> phone_ = <String>[];
  List<String> place_ = <String>[];
  List<String> post_ = <String>[];
  List<String> logo_ = <String>[];
  List<String> email_ = <String>[];
  List<String> status_ = <String>[];
  List<String> district_ = <String>[];
  List<String> longitude_ = <String>[];
  List<String> latitude_ = <String>[];
  _complaintState(){
    load();
  }
  Future<void> load() async {
    List<String> name = <String>[];
    List<String> id = <String>[];
    List<String> phone = <String>[];
    List<String> place = <String>[];
    List<String> post = <String>[];
    List<String> logo = <String>[];
    List<String> email = <String>[];
    List<String> statuss = <String>[];
    List<String> district = <String>[];
    List<String> longitude = <String>[];
    List<String> latitude = <String>[];


    try {
      final pref = await SharedPreferences.getInstance();
      String lid = pref.getString("lid").toString();
      String ip = pref.getString("url").toString();
      // String lid= pref.getString("lid").toString();

      String url = ip + "view_nearest_hospital";
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
        name.add(arr[i]['name'].toString());
        id.add(arr[i]['id'].toString());
        phone.add(arr[i]['phone'].toString());
        post.add(arr[i]['post'].toString());
        district.add(arr[i]['district'].toString());
        logo.add(arr[i]['logo'].toString());
        email.add(arr[i]['email'].toString());
        statuss.add(arr[i]['status'].toString());
        longitude.add(arr[i]['longitude'].toString());
        latitude.add(arr[i]['latitude'].toString());
      }
      setState(() {
        id_ = id;
        name_ = name;
        phone_ = phone;
        post_ = post;
        place_ = place;
        district_ = district;
        longitude_ = longitude;
        logo_ = logo;
        email_ = email;
        status_ = statuss;
        latitude_ = latitude;
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
        title: Text("Nearest Hospital"),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: id_.length,
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

                                // Flexible(flex: 2,
                                //     fit: FlexFit.loose,
                                //     child: Row(children: [Text(" Date")])),
                                // Flexible(flex: 3,
                                //     fit: FlexFit.loose,
                                //     child: Row(children: [Text(date_[index])])),

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
                                    child: Row(children: [Text("Hospital")])),
                                Flexible(flex: 3,
                                    fit: FlexFit.loose,
                                    child: Row(
                                        children: [Text(name_[index])])),

                                // Text("Place"),
                                // Text(place_[index])
                              ],
                            ),
                            SizedBox(height: 16,), Row(

                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                //
                                // Flexible(flex: 2,
                                //     fit: FlexFit.loose,
                                //     child: Row(children: [Text("Reply")])),
                                // Flexible(flex: 3,
                                //     fit: FlexFit.loose,
                                //     child: Row(
                                //         children: [Text(reply_[index])])),

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
    );
  }
}
