// import 'dart:convert';
//
// import 'package:ad_app_tm/ambulance/ambulance_home.dart';
// import 'package:ad_app_tm/ambulance/ambulance_registartion.dart';
// import 'package:ad_app_tm/user/user_home.dart';
// import 'package:ad_app_tm/user/user_registration.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController UsernameController=TextEditingController();
//   TextEditingController PasswordController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login page'),),
//       body: Padding(padding: EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Username'),
//               controller: UsernameController,
//             ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Password'),
//               controller: PasswordController,
//             ),
//             ElevatedButton(onPressed: sendData, child: Text('log in')),
//             TextButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceRegistration()));
//             }, child: Text('Ambulance Registration')),
//             TextButton(onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration()));
//             }, child: Text('User Registration')),
//           ],
//         ),),
//     );
//   }
//   Future<void> sendData() async {
//     String username=UsernameController.text.trim();
//     String password=PasswordController.text.trim();
//
//     if(username.isEmpty||password.isEmpty) {
//       Fluttertoast.showToast(msg: 'fill the  fields');
//       return;
//     }
//
//     final sh= await SharedPreferences.getInstance();
//     String? url= sh.getString('url');
//
//     final api=Uri.parse('$url/FlutterLogin/');
//
//     try {
//       final request= await http.post(api,body: {
//         'username':username,
//         'password':password,
//       });
//
//       if(request.statusCode == 200) {
//         var data = jsonDecode(request.body);
//         if(data['status']=='ok') {
//           final sh = await SharedPreferences.getInstance();
//           await sh.setString('lid', data['lid'].toString());
//           if(data['type'].toString()=="Ambulance") {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => AmbulanceHome()));
//           }
//           else if(data['type'].toString()=="User")
//            {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => UserHome()));
//           }
//         }
//         else {
//           Fluttertoast.showToast(msg: 'invalid username or password');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'connection error');
//       }
//
//     }catch (e){
//       Fluttertoast.showToast(msg: 'error:$e');
//     }
//
//   }
// }

import 'dart:convert';

import 'package:ad_app_tm/ambulance/ambulance_home.dart';
import 'package:ad_app_tm/ambulance/ambulance_registartion.dart';
import 'package:ad_app_tm/user/user_home.dart';
import 'package:ad_app_tm/user/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final Location _location = Location();

  double? latitude;
  double? longitude;
  String status = "Press button to get location";


  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextFormField(
              controller: UsernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: PasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: sendData,
              child: const Text('Login'),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AmbulanceRegistration()));
              },
              child: const Text('Ambulance Registration'),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserRegistration()));
              },
              child: const Text('User Registration'),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Get Current Location
  // Future<Position> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw 'Location permission denied';
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     throw 'Location permission permanently denied';
  //   }
  //
  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  /// 🔹 Login + Update Latitude & Longitude
  Future<void> sendData() async {

    String username = UsernameController.text.trim();
    String password = PasswordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Fill all fields');
      return;
    }

    try {


      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          setState(() => status = "Location service disabled");
          return;
        }
      }

      // 2️⃣ Check permission
      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != PermissionStatus.granted) {
          setState(() => status = "Location permission denied");
          return;
        }
      }
      // 3️⃣ Get location
      LocationData locationData = await _location.getLocation();

      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        status = "Location fetched successfully";
      });


      print(status);
      print("status");

      // Position position = await _getCurrentLocation();
      // String latitude = position.latitude.toString();
      // String longitude = position.longitude.toString();

      final sh = await SharedPreferences.getInstance();
      String? url = sh.getString('url');

      sh.setString("latitude", latitude.toString());
      sh.setString("longitude", longitude.toString());

      final api = Uri.parse('$url/FlutterLogin/');

      final response = await http.post(api, body: {
        'username': username,
        'password': password,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      if (response.statusCode == 200) {

        var data = jsonDecode(response.body);

        if (data['status'] == 'ok') {

          await sh.setString('lid', data['lid'].toString());

          if (data['type'] == "Ambulance") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AmbulanceHome()),
            );
          }
          else if (data['type'] == "User") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserHome()),
            );
          }
        }
        else {
          Fluttertoast.showToast(msg: 'Invalid username or password');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Server connection error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}
