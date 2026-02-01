// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class ViewNearestAccident extends StatefulWidget {
//   const ViewNearestAccident({super.key});
//
//   @override
//   State<ViewNearestAccident> createState() => _ViewNearestAccidentState();
// }
//
// class _ViewNearestAccidentState extends State<ViewNearestAccident> {
//   final Location _location = Location();
//   double? latitude;
//   double? longitude;
//   String status = "Fetching location...";
//   List accidents = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Future<void> getData() async {
//     LocationData locationData = await _location.getLocation();
//     latitude = locationData.latitude;
//     longitude = locationData.longitude;
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? lid = prefs.getString("lid");
//     String? ip = prefs.getString("url");
//
//     if (lid == null) {
//       setState(() {
//         status = "No lid found in SharedPreferences";
//         loading = false;
//       });
//       return;
//     }
//
//     var url = Uri.parse("${ip}/user_view_near_notification/");
//     var response = await http.post(url, body: {
//       "lid": lid,
//       "latitude": latitude.toString(),
//       "longitude": longitude.toString(),
//     });
//
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           accidents = jsonData['data'];
//           status = "Accidents fetched successfully";
//           loading = false;
//         });
//       } else {
//         setState(() {
//           status = "No accidents found";
//           loading = false;
//         });
//       }
//     } else {
//       setState(() {
//         status = "Error fetching data";
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Nearest Accidents")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : accidents.isEmpty
//           ? Center(child: Text(status))
//           : ListView.builder(
//         itemCount: accidents.length,
//         itemBuilder: (context, index) {
//           var accident = accidents[index];
//           return Card(
//             child: ListTile(
//               leading: accident['photo'] != ""
//                   ? Image.network(accident['photo'], width: 50, height: 50, fit: BoxFit.cover)
//                   : const Icon(Icons.warning, color: Colors.red),
//               title: Text("Reported by: ${accident['u_name']}"),
//               subtitle: Text("Date: ${accident['date']}"),
//               trailing: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(accident['u_phone'].toString()),
//                   Text("${accident['distance']} km away"),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewNearestAccident extends StatefulWidget {
  const ViewNearestAccident({super.key});

  @override
  State<ViewNearestAccident> createState() => _ViewNearestAccidentState();
}

class _ViewNearestAccidentState extends State<ViewNearestAccident> {
  final Location _location = Location();

  double? latitude;
  double? longitude;
  String? img_url;
  bool loading = true;
  String status = "Fetching location...";
  List accidents = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      LocationData locationData = await _location.getLocation();
      latitude = locationData.latitude;
      longitude = locationData.longitude;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? ip = prefs.getString("url");
      img_url = prefs.getString("img_url");

      if (ip == null) {
        setState(() {
          status = "Server URL not found";
          loading = false;
        });
        return;
      }

      var url = Uri.parse("$ip/user_view_near_accidents/");

      var response = await http.post(url, body: {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData['status'] == 'ok') {
          setState(() {
            accidents = jsonData['data'];
            loading = false;
          });
        } else {
          setState(() {
            status = "No accidents nearby";
            loading = false;
          });
        }
      } else {
        setState(() {
          status = "Server error";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        status = "Error: $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Accidents"),
        backgroundColor: Colors.red,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : accidents.isEmpty
          ? Center(
        child: Text(
          status,
          style: const TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: accidents.length,
        itemBuilder: (context, index) {
          var accident = accidents[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),

              leading: accident['photo'] != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  img_url!+accident['photo'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(Icons.warning, color: Colors.red, size: 40),

              title: Text(
                accident['u_name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text("Phone: ${accident['u_phone']}"),
                  Text("Date: ${accident['date']}"),
                  Text("Status: ${accident['status']}"),
                ],
              ),

              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  Text(
                    "${accident['distance']} km",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
