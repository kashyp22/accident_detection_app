// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class ambu_ViewNearestAccident extends StatefulWidget {
//   const ambu_ViewNearestAccident({super.key});
//
//   @override
//   State<ambu_ViewNearestAccident> createState() => _ambu_ViewNearestAccidentState();
// }
//
// class _ambu_ViewNearestAccidentState extends State<ambu_ViewNearestAccident> {
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
import 'package:ad_app_tm/ambulance/chat_hos.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ambu_ViewNearestAccident extends StatefulWidget {
  const ambu_ViewNearestAccident({super.key});

  @override
  State<ambu_ViewNearestAccident> createState() => _ambu_ViewNearestAccidentState();
}

class _ambu_ViewNearestAccidentState extends State<ambu_ViewNearestAccident> {
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

  Future<void> openMap(double lat, double lon) async {
    final Uri googleMapUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$lat,$lon");
      await launchUrl(
        googleMapUrl,
        mode: LaunchMode.externalApplication,
      );
  }

  Future<void> updateStatus(String accId, String newStatus) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? ip = prefs.getString("url");
      if (ip == null) return;
      var url = Uri.parse("$ip/ambulance_update_accident_status/");
      var response = await http.post(url, body: {
        "accident_id": accId,
        "status": newStatus,
      });
      if (response.statusCode == 200) {
        var res = json.decode(response.body);
        if (res['status'] == 'ok') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Status updated to $newStatus")),
          );
          getData(); // refresh list
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating status")),
      );
    }
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

      var url = Uri.parse("$ip/ambulance_view_near_accidents/");

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
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔹 HEADER
                  Row(
                    children: [
                      accident['photo'] != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          img_url! + accident['photo'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(Icons.warning, color: Colors.red, size: 60),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              accident['u_name'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text("📞 ${accident['u_phone']}"),
                            Text("📅 ${accident['date']}"),
                          ],
                        ),
                      ),

                      /// STATUS CHIP
                      Chip(
                        label: Text(
                          accident['status'].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: accident['status'] == "pending"
                            ? Colors.orange
                            : accident['status'] == "accepted"
                            ? Colors.blue
                            : accident['status'] == "delivered"
                            ? Colors.purple
                            : Colors.green,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 DISTANCE
                  Text(
                    "📍 Distance: ${accident['distance']} km",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  const Divider(height: 20),

                  /// 🔹 HOSPITAL ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "🏥 ${accident['hos_name']}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.chat, color: Colors.green),
                        onPressed: () async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          sh.setString(
                              "hos_lid", accident['hos_lid'].toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyChatPage(title: "Chat")),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// 🔹 NAVIGATION BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.location_on),
                          label: const Text("Accident"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            openMap(
                              double.parse(accident['latitude'].toString()),
                              double.parse(accident['longitude'].toString()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.local_hospital),
                          label: const Text("Hospital"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            openMap(
                              double.parse(accident['hos_latitude'].toString()),
                              double.parse(accident['hos_longitude'].toString()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 UPDATE STATUS
                  if (accident['status'] != "completed")
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.update),
                        label: const Text("Update Status"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          showStatusDialog(
                            accident['id'].toString(),
                            accident['status'],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );



          // return Card(
          //   elevation: 4,
          //   margin: const EdgeInsets.symmetric(vertical: 8),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: ListTile(
          //     contentPadding: const EdgeInsets.all(10),
          //
          //     leading: accident['photo'] != null
          //         ? ClipRRect(
          //       borderRadius: BorderRadius.circular(8),
          //       child: Image.network(
          //         img_url!+accident['photo'],
          //         width: 60,
          //         height: 60,
          //         fit: BoxFit.cover,
          //       ),
          //     )
          //         : const Icon(Icons.warning, color: Colors.red, size: 40),
          //
          //     title: Text(
          //       accident['u_name'],
          //       style: const TextStyle(
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //
          //     subtitle: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         const SizedBox(height: 4),
          //         Text("Phone: ${accident['u_phone']}"),
          //         Text("Date: ${accident['date']}"),
          //         Text("Status: ${accident['status']}"),
          //         Text(
          //           "${accident['distance']} km",
          //           style: const TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //
          //         Text("Chat with Hospital:${accident['hos_name']}"),IconButton(onPressed: ()async{
          //           SharedPreferences sh = await SharedPreferences.getInstance();
          //           sh.setString("hos_lid", accident['hos_lid'].toString());
          //
          //           Navigator.push(context, MaterialPageRoute(builder: (context)=>MyChatPage(title: "Chat")));
          //
          //
          //         }, icon: Icon(Icons.chat)),
          //
          //         ElevatedButton.icon(
          //           onPressed: () {
          //             openMap(
          //               double.parse(accident['hos_latitude'].toString()),
          //               double.parse(accident['hos_longitude'].toString()),
          //             );
          //           },
          //           icon: const Icon(Icons.navigation, size: 18),
          //           label: const Text("Hospital"),
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.red,
          //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //           ),
          //         ),
          //
          //         if (accident['status'] != "completed")
          //           ElevatedButton(
          //             onPressed: () {
          //               showStatusDialog(
          //                 accident['id'].toString(),
          //                 accident['status'],
          //               );
          //             },
          //             child: const Text("Update Status"),
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: Colors.black,
          //             ),
          //           ),
          //       ],
          //     ),
          //     trailing: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         ElevatedButton.icon(
          //           onPressed: () {
          //             openMap(
          //               double.parse(accident['latitude'].toString()),
          //               double.parse(accident['longitude'].toString()),
          //             );
          //           },
          //           icon: const Icon(Icons.navigation, size: 18),
          //           label: const Text("Accident"),
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.red,
          //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          //           ),
          //         ),
          //       ],
          //     ),
          //
          //
          //   ),
          // );
        },
      ),
    );
  }

  void showStatusDialog(String accId, String currentStatus) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Update Accident Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /// 🔹 PENDING → ACCEPTED
              if (currentStatus == "pending")
                statusTile("accepted", Colors.green, accId),

              /// 🔹 ACCEPTED → DELIVERED
              if (currentStatus == "accepted")
                statusTile("delivered", Colors.orange, accId),

              /// 🔹 DELIVERED → COMPLETED
              if (currentStatus == "delivered")
                statusTile("completed", Colors.blue, accId),
            ],
          ),
        );
      },
    );
  }



  Widget statusTile(String status, Color color, String accId) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: color),
      title: Text(status),
      onTap: () {
        Navigator.pop(context);
        updateStatus(accId, status);
      },
    );
  }

}
