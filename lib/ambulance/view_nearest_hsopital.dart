// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
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
//       home: view_nearest_hospital(),
//     );
//   }
// }
//
//
// class view_nearest_hospital extends StatefulWidget {
//   const view_nearest_hospital({super.key});
//
//
//
//   @override
//   State<view_nearest_hospital> createState() => _view_nearest_hospitalState();
// }
//
// class _view_nearest_hospitalState extends State<view_nearest_hospital> {
//
//   final Location _location = Location();
//
//   double? latitude;
//   double? longitude;
//   String status = "Press button to get location";
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     get_data();
//
//   }
//   get_data()async{
//     LocationData locationData = await _location.getLocation();
//
//     setState(() {
//       latitude = locationData.latitude;
//       longitude = locationData.longitude;
//       status = "Location fetched successfully";
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//
//
//
//
//
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Nearest Hospital"),
//         ),
//         body: Center(
//           child: Text("Home"),
//         )
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ViewNearestHospital(),
    );
  }
}

class ViewNearestHospital extends StatefulWidget {
  const ViewNearestHospital({super.key});

  @override
  State<ViewNearestHospital> createState() => _ViewNearestHospitalState();
}

class _ViewNearestHospitalState extends State<ViewNearestHospital> {
  final Location _location = Location();
  double? latitude;
  double? longitude;
  String status = "Fetching location...";
  List hospitals = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get user location
    LocationData locationData = await _location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;

    // Get lid from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lid = prefs.getString("lid");
    String? ip = prefs.getString("url");

    if (lid == null) {
      setState(() {
        status = "No lid found in SharedPreferences";
        loading = false;
      });
      return;
    }

    // Call Django API
    var url = Uri.parse("${ip}/ambulance_view_nearest_hospital/");
    var response = await http.post(url, body: {
      "lid": lid,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == 'ok') {
        setState(() {
          hospitals = jsonData['data'];
          print(hospitals);
          print("hospitals");
          status = "Hospitals fetched successfully";
          loading = false;
        });
      } else {
        setState(() {
          status = "No hospitals found";
          loading = false;
        });
      }
    } else {
      setState(() {
        status = "Error fetching data";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearest Hospital")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : hospitals.isEmpty
          ? Center(child: Text(status))
          : ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          var hospital = hospitals[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.local_hospital,
                  color: Colors.red),
              title: Text(hospital['name']),
              subtitle: Text(
                  "${hospital['place']} • ${hospital['district']}"),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(hospital['phone'].toString()),
                  Text("${hospital['distance']} km"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}