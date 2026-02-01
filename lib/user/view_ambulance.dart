// import 'dart:convert';
// import 'dart:math';
//
//
//
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
//
//
// class viewambulance extends StatelessWidget {
//   const viewambulance({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.red,
//       ),
//       home: const viewambulancepagePage(title: 'Flutter Demo Home Page'),
//       routes: {
//
//       },
//     );
//   }
// }
//
// class viewambulancepagePage extends StatefulWidget {
//   const viewambulancepagePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<viewambulancepagePage> createState() => _viewambulancepagePage();
// }
//
// class _viewambulancepagePage extends State<viewambulancepagePage> {
//   int _counter = 0;
//
//   _viewambulancepagePage() {
//     view_notification();
//   }
//
//
//
//   List<String> cid_ = <String>[];
//   List<String> cregno_ = <String>[];
//   List<String> cname_ = <String>[];
//   List<String> cphone_ = <String>[];
//   List<String> cemail_= <String>[];
//   List<String> clatitude_ = <String>[];
//   List<String> clongitude_ = <String>[];
//   List<String> cstatus_ = <String>[];
//   List<String> crcno_ = <String>[];
//
//
//
//   Future<void> view_notification() async {
//     List<String> cid = <String>[];
//     List<String> cregno = <String>[];
//     List<String> cname = <String>[];
//     List<String> cphone = <String>[];
//     List<String> cemail = <String>[];
//     List<String> clatitude = <String>[];
//     List<String> clongitude = <String>[];
//     List<String> cstatus = <String>[];
//     List<String> crcno = <String>[];
//
//
//     try {
//       final pref=await SharedPreferences.getInstance();
//       String ip= pref.getString("url").toString();
//       // String lid= pref.getString("lid").toString();
//
//       String url=ip+"ambulance_view_notification";
//       print(url);
//       print("=========================");
//
//       var data = await http.post(Uri.parse(url), body: {
//       });
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr);
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         print("okkkkkkkkkkkkkkkkkkkkkkkk");
//         cid.add(arr[i]['id'].toString());
//         cregno.add(arr[i]['regno'].toString());
//         cname.add(arr[i]['name'].toString());
//         cphone.add(arr[i]['phone'].toString());
//         cemail.add(arr[i]['email'].toString());
//         clatitude.add(arr[i]['latitude'].toString());
//         clongitude.add(arr[i]['longitude'].toString());
//         cstatus.add(arr[i]['status'].toString());
//         crcno.add(arr[i]['rcno'].toString());
//         print("ppppppppppppppppppp");
//       }
//
//       setState(() {
//         cid_ = cid;
//         cregno_ = cregno;
//         cname_ = cname;
//         cphone_ = cphone;
//         cemail_ = cemail;
//         clatitude_ = clatitude;
//
//         clongitude_ = clongitude;
//         cstatus_ = cstatus;
//         crcno_ = crcno;
//
//       });
//
//       print(cid_.length);
//       print("+++++++++++++++++++++");
//       print(status);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//         appBar: AppBar(
//             title: new Text(
//               "View All  Bus",
//               style: new TextStyle(color: Colors.white),
//             ),
//             leading: new IconButton(
//               icon: new Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//                 // Navigator.pushNamed(context, '/home');
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => const  MyHomePage(title: '',)),);
//                 print("Hello");
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => ThirdScreen()),
//                 // );
//               },
//             )
//         ),
//
//         body:
//
//
//
//
//         ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: cid_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Column(
//                     children: [
//
//
//                       Container(
//                         width: MediaQuery. of(context). size. width,
//                         height: 500,
//                         child: Card(
//                           clipBehavior: Clip.antiAliasWithSaveLayer,
//                           child: Column(
//                             children: [
//
//
//
//
//
//
//
//                               SizedBox(height: 16,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Regno")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(cregno_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ),
//                               SizedBox(height: 16,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Name")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(cname_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ),
//
//
//                               SizedBox(height: 16,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Phone")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(cphone_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ),
//                               SizedBox(height: 9,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Email")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(cemail_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ), SizedBox(height: 9,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Latitude")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(clatitude_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ),
//                               SizedBox(height: 9,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Longitude")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(clongitude_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ), SizedBox(height: 9,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Status")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(cstatus_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ), SizedBox(height: 9,),
//                               Row(
//
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//
//                                   Flexible(flex: 2, fit: FlexFit.loose, child: Row(children: [Text("Rcno")])),
//                                   Flexible(flex: 3, fit: FlexFit.loose, child: Row(children: [Text(crcno_[index])])),
//
//                                   // Text("Place"),
//                                   // Text(place_[index])
//                                 ],
//                               ), SizedBox(height: 9,),
//
//                               Container(
//                                 padding: EdgeInsets.all(5.0),
//                                 child:   Row(
//
//                                   children: [
//
//
//                                     SizedBox(width: 10.0,),
//                                     ElevatedButton(
//                                       onPressed: () async {
//
//                                         SharedPreferences prefs = await SharedPreferences.getInstance();
//                                         prefs.setString('bid', cid_[index]);
//
//
//
//
//                                       },
//                                       child: Text('view bus route'),
//                                     ),
//
//                                   ],
//                                 ),
//                               )
//
//
//                               // Column(
//                               //     mainAxisAlignment: MainAxisAlignment.start,
//                               //     crossAxisAlignment: CrossAxisAlignment.start,
//                               //     children:[
//                               //   Text('Title'),
//                               //   Text('Subtitle')
//                               // ])
//                             ],
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           elevation: 5,
//                           margin: EdgeInsets.all(10),
//                         ),
//                       ),
//
//
//                     ],
//                   )),
//             );
//           },
//
//         )
//
//
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//
//
//
//
//
// }
//
//
//
//
//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearAmbulancePage extends StatefulWidget {

  const NearAmbulancePage({
    Key? key,
  }) : super(key: key);

  @override
  _NearAmbulancePageState createState() => _NearAmbulancePageState();
}

class _NearAmbulancePageState extends State<NearAmbulancePage> {
  List<dynamic> ambulances = [];
  final Location _location = Location();

  bool isLoading = true;
  String errorMessage = "";
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    fetchAmbulances();
  }

  Future<void> fetchAmbulances() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? lid = prefs.getString("lid");
      String? ip = prefs.getString("url");

      LocationData locationData = await _location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;
      var url = Uri.parse("${ip}/user_view_near_ambulance/");
      var response = await http.post(url, body: {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'ok') {
          setState(() {
            ambulances = jsonResponse['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = "No ambulances found nearby.";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Server error: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Ambulances")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
        itemCount: ambulances.length,
        itemBuilder: (context, index) {
          var ambulance = ambulances[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.red),
              title: Text("${ambulance['registration_no']} - ${ambulance['drivers_name']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone: ${ambulance['phone']}"),
                  Text("Email: ${ambulance['email']}"),
                  Text("Status: ${ambulance['status']}"),
                  Text("Distance: ${ambulance['distance']} km"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // You can integrate direct call functionality here
                },
              ),
            ),
          );
        },
      ),
    );
  }
}