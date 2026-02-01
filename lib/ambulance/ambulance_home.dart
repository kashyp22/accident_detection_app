// // import 'dart:async';
// // import 'dart:convert';
// //
// // import 'package:ad_app_tm/ambulance/ambu_near_accidents.dart';
// // import 'package:ad_app_tm/ambulance/edit_profile.dart';
// // import 'package:ad_app_tm/ambulance/send_complaint.dart';
// // import 'package:ad_app_tm/ambulance/view_complaint.dart';
// // import 'package:ad_app_tm/ambulance/view_nearest_hsopital.dart';
// // import 'package:ad_app_tm/ambulance/view_notification.dart';
// // import 'package:ad_app_tm/ambulance/view_profile.dart';
// // import 'package:ad_app_tm/login.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// //
// // void main(){
// //   runApp(App());
// // }
// //
// //
// // class App extends StatelessWidget {
// //   const App({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //
// //       home: AmbulanceHome(),
// //     );
// //   }
// // }
// //
// //
// // class AmbulanceHome extends StatefulWidget {
// //   const AmbulanceHome({super.key});
// //
// //
// //
// //
// //
// //
// //   @override
// //   State<AmbulanceHome> createState() => _AmbulanceHomeState();
// // }
// //
// // class _AmbulanceHomeState extends State<AmbulanceHome> {
// //
// //   Timer? emergencyTimer;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     emergencyTimer = Timer.periodic(Duration(seconds: 10), (timer) {
// //       checkEmergencyNotification();  // auto check every 10 seconds
// //     });
// //   }
// //
// //   Future<void> checkEmergencyNotification() async {
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String ip = sh.getString("url").toString();
// //     String latitude = sh.getString("latitude").toString();
// //     String longitude = sh.getString("longitude").toString();
// //     String lid = sh.getString("lid").toString();
// //
// //     var url = Uri.parse("${ip}/ambulance_view_accident_notification/");   // Base URL മാറ്റൂ
// //     var response = await http.post(url, body: {
// //       'lid': lid, // if needed send user id / empty
// //       'latitude': latitude,// if needed send user id / empty
// //       'longitude': longitude  // if needed send user id / empty
// //     });
// //
// //     print(response.body);
// //
// //     var data = json.decode(response.body);
// //     if (data["status"] == "ok" && data["data"].length > 0) {
// //       // If emergency exists, show local notification
// //       await showNotification(
// //           "Accident Alert",
// //           "${data["data"][0]["distance"]} km!"
// //       );
// //     }
// //   }
// //
// // // Local Notification function
// //   Future<void> showNotification(String title, String body) async {
// //     const AndroidNotificationDetails androidDetails =
// //     AndroidNotificationDetails(
// //       'emergency_channel',
// //       'Emergency Alerts',
// //       importance: Importance.max,
// //       priority: Priority.high,
// //     );
// //
// //     const NotificationDetails notificationDetails =
// //     NotificationDetails(android: androidDetails);
// //
// //     await FlutterLocalNotificationsPlugin().show(
// //       0,
// //       title,
// //       body,
// //       notificationDetails,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Ambulance Home"),
// //         actions: [
// //           IconButton(onPressed: (){
// //
// //             Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
// //
// //           }, icon: Icon(Icons.logout))
// //         ],
// //       ),
// //       body: Center(
// //         child: Text("Home"),
// //       ),
// //       drawer: Drawer(
// //
// //
// //         child: Column(
// //
// //           children: [
// //             DrawerHeader(child: Text("Hi John")),
// //             SizedBox(height: 10,),
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("Profile"),onTap: (){
// //
// //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AmbulanceViewProfile()));
// //
// //
// //             },),
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("Send Complaint"),onTap: (){
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>NewComplaintPage()));
// //
// //
// //             },),
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("View Complaint"),onTap: (){
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>complaint()));
// //
// //
// //             },),
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("Nearest Hospital"),onTap: (){
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNearestHospital()));
// //
// //
// //             },),
// //
// //
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("View Notification"),onTap: (){
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>viewnotificationpagePage(title: '',)));
// //
// //
// //             },),
// //
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text("View Accidents Near Me"),onTap: (){
// //
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>ambu_ViewNearestAccident()));
// //
// //
// //             },),
// //
// //
// //           ],
// //         ),
// //
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'dart:async';
// import 'dart:convert';
// import 'package:ad_app_tm/ambulance/ambu_near_accidents.dart';
// import 'package:ad_app_tm/ambulance/edit_profile.dart';
// import 'package:ad_app_tm/ambulance/send_complaint.dart';
// import 'package:ad_app_tm/ambulance/view_complaint.dart';
// import 'package:ad_app_tm/ambulance/view_nearest_hsopital.dart';
// import 'package:ad_app_tm/ambulance/view_notification.dart';
// import 'package:ad_app_tm/ambulance/view_profile.dart';
// import 'package:ad_app_tm/login.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(App());
// }
//
// class App extends StatelessWidget {
//   const App({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         scaffoldBackgroundColor: Colors.grey[50],
//       ),
//       home: AmbulanceHome(),
//     );
//   }
// }
//
// class AmbulanceHome extends StatefulWidget {
//   const AmbulanceHome({super.key});
//
//   @override
//   State<AmbulanceHome> createState() => _AmbulanceHomeState();
// }
//
// class _AmbulanceHomeState extends State<AmbulanceHome> {
//   Timer? emergencyTimer;
//   String userName = "John";
//   int activeEmergencies = 0;
//   bool isOnDuty = true;
//   bool isOnline = false;
//   String status_ambulance ="Offline";
//   final Location _location = Location();
//
//
//
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   loadUserData();
//   //   emergencyTimer = Timer.periodic(Duration(seconds: 10), (timer) {
//   //     checkEmergencyNotification();
//   //   });
//   // }
//
//   @override
//   void dispose() {
//     emergencyTimer?.cancel();
//     super.dispose();
//   }
//
//   Future<void> loadUserData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       userName = sh.getString("name") ?? "John";
//     });
//   }
//
//   Future<void> checkEmergencyNotification() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String ip = sh.getString("url").toString();
//     String latitude = sh.getString("latitude").toString();
//     String longitude = sh.getString("longitude").toString();
//     String lid = sh.getString("lid").toString();
//
//     var url = Uri.parse("${ip}/ambulance_view_accident_notification/");
//     var response = await http.post(url, body: {
//       'lid': lid,
//       'latitude': latitude,
//       'longitude': longitude
//     });
//
//     print(response.body);
//     var data = json.decode(response.body);
//
//     if (data["status"] == "ok" && data["data"].length > 0) {
//       setState(() {
//         activeEmergencies = data["data"].length;
//       });
//
//       await showNotification(
//           "Accident Alert",
//           "${data["data"][0]["distance"]} km away!"
//       );
//     }
//   }
//
//   Future<void> showNotification(String title, String body) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'emergency_channel',
//       'Emergency Alerts',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails notificationDetails =
//     NotificationDetails(android: androidDetails);
//
//     await FlutterLocalNotificationsPlugin().show(
//       0,
//       title,
//       body,
//       notificationDetails,
//     );
//   }
//
//   Future<void> updateStatus(bool value) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     final String baseUrl = sh.getString("url").toString();
//     final String lid = sh.getString("lid").toString();
//
//     final url = value
//         ? "$baseUrl/online_update_status/"
//         : "$baseUrl/offline_update_status/";
//
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {'lid': lid},
//       );
//
//       if (response.statusCode == 200) {
//         setState(() {
//           isOnline = value;
//           status_ambulance = value ? "Online" : "Offline";
//         });
//
//         // ✅ CONTROL TIMER HERE
//         if (value) {
//
//           print("hiii");
//           startLocationUpdates(); // ONLINE
//         } else {
//           stopLocationUpdates();  // OFFLINE
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to update status")),
//       );
//     }
//   }
//
//   Future<void> getCurrentLocation() async {
//     try {
//       // 1️⃣ Check service
//       bool serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           setState(() => status = "Location service disabled");
//           return;
//         }
//       }
//
//       // 2️⃣ Check permission
//       PermissionStatus permission = await _location.hasPermission();
//       if (permission == PermissionStatus.denied) {
//         permission = await _location.requestPermission();
//         if (permission != PermissionStatus.granted) {
//           setState(() => status = "Location permission denied");
//           return;
//         }
//       }
//
//       // 3️⃣ Get location
//       LocationData locationData = await _location.getLocation();
//
//       setState(() {
//         latitude = locationData.latitude;
//         longitude = locationData.longitude;
//         status = "Location fetched successfully";
//       });
//     } catch (e) {
//       setState(() => status = "Error: $e");
//     }
//   }
//
//
//   void startLocationUpdates() {
//     emergencyTimer?.cancel(); // safety: cancel existing timer
//
//     emergencyTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
//       await getCurrentLocation();
//       await updatelocation();
//     });
//   }
//
//   void stopLocationUpdates() {
//     emergencyTimer?.cancel();
//     emergencyTimer = null;
//   }
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.red[700],
//         title: Row(
//           children: [
//             Icon(Icons.local_hospital, color: Colors.white),
//             SizedBox(width: 8),
//             Text(
//               "Ambulance",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           // Duty Status Toggle
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Center(
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: isOnDuty ? Colors.green : Colors.grey,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       isOnDuty ? Icons.check_circle : Icons.cancel,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       isOnDuty ? "On Duty" : "Off Duty",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginPage()),
//               );
//             },
//             icon: Icon(Icons.logout, color: Colors.white),
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Emergency Alert Banner
//             if (activeEmergencies > 0) _buildEmergencyBanner(),
//
//             // Quick Stats Cards
//             // _buildStatsSection(),
//
//             // Quick Access Menu
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Quick Access",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[800],
//                 ),
//               ),
//             ),
//             _buildQuickAccessGrid(),
//
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident()),
//           );
//         },
//         backgroundColor: Colors.red[700],
//         icon: Icon(Icons.warning_amber_rounded),
//         label: Text("View Emergencies"),
//       ),
//     );
//   }
//
//   Widget _buildEmergencyBanner() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.red[700]!, Colors.red[900]!],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.red.withOpacity(0.3),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.emergency, color: Colors.white, size: 40),
//           SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "ACTIVE EMERGENCY",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   "$activeEmergencies accident(s) nearby",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Icon(Icons.chevron_right, color: Colors.white),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatsSection() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildStatCard(
//               "Active Calls",
//               activeEmergencies.toString(),
//               Icons.phone_in_talk,
//               Colors.red,
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: _buildStatCard(
//               "Status",
//               isOnDuty ? "On Duty" : "Off Duty",
//               Icons.local_hospital,
//               isOnDuty ? Colors.green : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatCard(String label, String value, IconData icon, Color color) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color, size: 30),
//           SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickAccessGrid() {
//     final menuItems = [
//       MenuItemData(
//         "Nearby Accidents",
//         Icons.warning_amber_rounded,
//         Colors.red,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident())),
//       ),
//       MenuItemData(
//         "Nearest Hospital",
//         Icons.local_hospital,
//         Colors.blue,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNearestHospital())),
//       ),
//       MenuItemData(
//         "Notifications",
//         Icons.notifications_active,
//         Colors.orange,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotificationpagePage(title: ''))),
//       ),
//       MenuItemData(
//         "My Profile",
//         Icons.person,
//         Colors.purple,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceViewProfile())),
//       ),
//       MenuItemData(
//         "Send Complaint",
//         Icons.report_problem,
//         Colors.amber,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewComplaintPage())),
//       ),
//       MenuItemData(
//         "View Complaints",
//         Icons.list_alt,
//         Colors.teal,
//             () => Navigator.push(context, MaterialPageRoute(builder: (context) => complaint())),
//       ),
//     ];
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1.2,
//         ),
//         itemCount: menuItems.length,
//         itemBuilder: (context, index) {
//           final item = menuItems[index];
//           return _buildQuickAccessCard(
//             item.title,
//             item.icon,
//             item.color,
//             item.onTap,
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildQuickAccessCard(
//       String title,
//       IconData icon,
//       Color color,
//       VoidCallback onTap,
//       ) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 icon,
//                 color: color,
//                 size: 32,
//               ),
//             ),
//             SizedBox(height: 12),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Column(
//         children: [
//           // UserAccountsDrawerHeader(
//           //   decoration: BoxDecoration(
//           //     gradient: LinearGradient(
//           //       colors: [Colors.red[700]!, Colors.red[900]!],
//           //       begin: Alignment.topLeft,
//           //       end: Alignment.bottomRight,
//           //     ),
//           //   ),
//           //   currentAccountName: Text(
//           //     userName,
//           //     style: TextStyle(
//           //       fontSize: 20,
//           //       fontWeight: FontWeight.bold,
//           //     ),
//           //   ),
//           //   currentAccountEmail: Text("Ambulance Driver"),
//           //   accountPicture: CircleAvatar(
//           //     backgroundColor: Colors.white,
//           //     child: Icon(
//           //       Icons.person,
//           //       size: 40,
//           //       color: Colors.red[700],
//           //     ),
//           //   ),
//           // ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildDrawerItem(
//                   Icons.person,
//                   "My Profile",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceViewProfile())),
//                 ),
//                 // _buildDrawerItem(
//                 //   Icons.edit,
//                 //   "Edit Profile",
//                 //       () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile())),
//                 // ),
//                 Divider(),
//                 _buildDrawerItem(
//                   Icons.warning_amber_rounded,
//                   "Nearby Accidents",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident())),
//                 ),
//                 _buildDrawerItem(
//                   Icons.local_hospital,
//                   "Nearest Hospital",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNearestHospital())),
//                 ),
//                 _buildDrawerItem(
//                   Icons.notifications_active,
//                   "Notifications",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => viewnotificationpagePage(title: ''))),
//                 ),
//                 Divider(),
//                 _buildDrawerItem(
//                   Icons.report_problem,
//                   "Send Complaint",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewComplaintPage())),
//                 ),
//                 _buildDrawerItem(
//                   Icons.list_alt,
//                   "View Complaints",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => complaint())),
//                 ),
//                 Divider(),
//                 _buildDrawerItem(
//                   Icons.logout,
//                   "Logout",
//                       () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
//     return ListTile(
//       leading: Icon(icon, color: color ?? Colors.grey[700]),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: color ?? Colors.grey[800],
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       onTap: onTap,
//       trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
//     );
//   }
// }
//
// class MenuItemData {
//   final String title;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;
//
//   MenuItemData(this.title, this.icon, this.color, this.onTap);
// }




import 'dart:async';
import 'dart:convert';
import 'package:ad_app_tm/ambulance/ambu_near_accidents.dart';
import 'package:ad_app_tm/ambulance/edit_profile.dart';
import 'package:ad_app_tm/ambulance/send_complaint.dart';
import 'package:ad_app_tm/ambulance/view_complaint.dart';
import 'package:ad_app_tm/ambulance/view_nearest_hsopital.dart';
import 'package:ad_app_tm/ambulance/view_notification.dart';
import 'package:ad_app_tm/ambulance/view_profile.dart';
import 'package:ad_app_tm/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: AmbulanceHome(),
    );
  }
}

class AmbulanceHome extends StatefulWidget {
  const AmbulanceHome({super.key});

  @override
  State<AmbulanceHome> createState() => _AmbulanceHomeState();
}

class _AmbulanceHomeState extends State<AmbulanceHome> {
  Timer? emergencyTimer;
  String userName = "John";
  int activeEmergencies = 0;
  bool isOnline = false;
  String statusAmbulance = "Offline";
  String status = "Waiting for location...";
  double? latitude;
  double? longitude;

  final Location _location = Location();
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    loadUserData();
  }

  @override
  void dispose() {
    emergencyTimer?.cancel();
    super.dispose();
  }

  // Initialize local notifications
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(initSettings);
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    setState(() {
      userName = sh.getString("name") ?? "John";
    });
  }

  // Check for emergency notifications
  Future<void> checkEmergencyNotification() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("url").toString();
    String lat = latitude?.toString() ?? sh.getString("latitude").toString();
    String lon = longitude?.toString() ?? sh.getString("longitude").toString();
    String lid = sh.getString("lid").toString();

    var url = Uri.parse("${ip}/ambulance_view_accident_notification/");

    try {
      var response = await http.post(url, body: {
        'lid': lid,
        'latitude': lat,
        'longitude': lon
      });

      print(response.body);
      var data = json.decode(response.body);

      if (data["status"] == "ok" && data["data"].length > 0) {
        setState(() {
          activeEmergencies = data["data"].length;
        });

        await showNotification(
            "Accident Alert",
            "${data["data"][0]["distance"]} km away!"
        );
      }
    } catch (e) {
      print("Error checking emergency: $e");
    }
  }

  // Show local notification
  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'emergency_channel',
      'Emergency Alerts',
      channelDescription: 'Notifications for emergency accidents',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // Update online/offline status
  Future<void> updateStatus(bool value) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    final String baseUrl = sh.getString("url").toString();
    final String lid = sh.getString("lid").toString();

    final url = value
        ? "$baseUrl/online_update_status/"
        : "$baseUrl/offline_update_status/";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'lid': lid},
      );

      if (response.statusCode == 200) {
        setState(() {
          isOnline = value;
          statusAmbulance = value ? "Online" : "Offline";
        });

        // Start or stop location updates based on status
        if (value) {
          startLocationUpdates();
        } else {
          stopLocationUpdates();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value ? "You are now Online" : "You are now Offline"),
            backgroundColor: value ? Colors.green : Colors.grey,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update status")),
      );
    }
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    try {
      // Check if service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          setState(() => status = "Location service disabled");
          return;
        }
      }

      // Check permission
      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != PermissionStatus.granted) {
          setState(() => status = "Location permission denied");
          return;
        }
      }

      // Get location
      LocationData locationData = await _location.getLocation();

      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        status = "Location updated";
      });

      // Save to SharedPreferences
      SharedPreferences sh = await SharedPreferences.getInstance();
      await sh.setString("latitude", latitude.toString());
      await sh.setString("longitude", longitude.toString());
    } catch (e) {
      setState(() => status = "Error: $e");
      print("Location error: $e");
    }
  }

  // Update location to server
  Future<void> updateLocation() async {
    if (latitude == null || longitude == null) return;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String ip = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    try {
      var url = Uri.parse("${ip}/update_ambulance_location/");
      var response = await http.post(url, body: {
        'lid': lid,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      print("Location update response: ${response.body}");
    } catch (e) {
      print("Error updating location: $e");
    }
  }

  // Start periodic location updates
  void startLocationUpdates() {
    emergencyTimer?.cancel();

    emergencyTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await getCurrentLocation();
      await updateLocation();
      await checkEmergencyNotification();
    });

    // Get initial location immediately
    getCurrentLocation();
  }

  // Stop location updates
  void stopLocationUpdates() {
    emergencyTimer?.cancel();
    emergencyTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[700],
        title: Row(
          children: [
            Icon(Icons.local_hospital, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Ambulance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // Online/Offline Status Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: GestureDetector(
                onTap: () => updateStatus(!isOnline),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isOnline ? Icons.check_circle : Icons.cancel,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        statusAmbulance,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency Alert Banner
            if (activeEmergencies > 0) _buildEmergencyBanner(),

            // Status Info Card
            _buildStatusCard(),

            // Quick Access Menu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            _buildQuickAccessGrid(),

            SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident()),
          );
        },
        backgroundColor: Colors.red[700],
        icon: Icon(Icons.warning_amber_rounded),
        label: Text("View Emergencies"),
      ),
    );
  }

  // Emergency Alert Banner
  Widget _buildEmergencyBanner() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident()),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red[700]!, Colors.red[900]!],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.emergency, color: Colors.white, size: 40),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ACTIVE EMERGENCY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "$activeEmergencies accident(s) nearby",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Status Info Card
  Widget _buildStatusCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: isOnline ? Colors.green : Colors.grey,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
          if (latitude != null && longitude != null) ...[
            SizedBox(height: 8),
            Text(
              "Lat: ${latitude!.toStringAsFixed(6)}, Lon: ${longitude!.toStringAsFixed(6)}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Quick Access Grid
  Widget _buildQuickAccessGrid() {
    final menuItems = [
      MenuItemData(
        "Nearby Accidents",
        Icons.warning_amber_rounded,
        Colors.red,
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident()),
        ),
      ),
      MenuItemData(
        "Nearest Hospital",
        Icons.local_hospital,
        Colors.blue,
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewNearestHospital()),
        ),
      ),
      // MenuItemData(
      //   "Notifications",
      //   Icons.notifications_active,
      //   Colors.orange,
      //       () => Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => viewnotificationpagePage(title: '')),
      //   ),
      // ),
      MenuItemData(
        "My Profile",
        Icons.person,
        Colors.purple,
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AmbulanceViewProfile()),
        ),
      ),
      MenuItemData(
        "Send Complaint",
        Icons.report_problem,
        Colors.amber,
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewComplaintPage()),
        ),
      ),
      MenuItemData(
        "View Complaints",
        Icons.list_alt,
        Colors.teal,
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => complaint()),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _buildQuickAccessCard(
            item.title,
            item.icon,
            item.color,
            item.onTap,
          );
        },
      ),
    );
  }

  // Quick Access Card
  Widget _buildQuickAccessCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navigation Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red[700]!, Colors.red[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.red[700],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ambulance Driver",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  Icons.person,
                  "My Profile",
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AmbulanceViewProfile()),
                  ),
                ),
                // _buildDrawerItem(
                //   Icons.edit,
                //   "Edit Profile",
                //       () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => EditProfile()),
                //   ),
                // ),
                Divider(),
                _buildDrawerItem(
                  Icons.warning_amber_rounded,
                  "Nearby Accidents",
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ambu_ViewNearestAccident()),
                  ),
                ),
                // _buildDrawerItem(
                //   Icons.local_hospital,
                //   "Nearest Hospital",
                //       () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ViewNearestHospital()),
                //   ),
                // ),
                // _buildDrawerItem(
                //   Icons.notifications_active,
                //   "Notifications",
                //       () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => viewnotificationpagePage(title: '')),
                //   ),
                // ),
                // Divider(),
                _buildDrawerItem(
                  Icons.report_problem,
                  "Send Complaint",
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewComplaintPage()),
                  ),
                ),
                _buildDrawerItem(
                  Icons.list_alt,
                  "View Complaints",
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => complaint()),
                  ),
                ),
                Divider(),
                _buildDrawerItem(
                  Icons.logout,
                  "Logout",
                      () {
                    stopLocationUpdates();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Drawer Item
  Widget _buildDrawerItem(
      IconData icon,
      String title,
      VoidCallback onTap, {
        Color? color,
      }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
    );
  }
}

// Menu Item Data Class
class MenuItemData {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  MenuItemData(this.title, this.icon, this.color, this.onTap);
}