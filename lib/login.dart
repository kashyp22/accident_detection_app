// // import 'dart:convert';
// //
// // import 'package:ad_app_tm/ambulance/ambulance_home.dart';
// // import 'package:ad_app_tm/ambulance/ambulance_registartion.dart';
// // import 'package:ad_app_tm/user/user_home.dart';
// // import 'package:ad_app_tm/user/user_registration.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:geolocator/geolocator.dart';
// //
// //
// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});
// //
// //   @override
// //   State<LoginPage> createState() => _LoginPageState();
// // }
// //
// // class _LoginPageState extends State<LoginPage> {
// //   TextEditingController UsernameController=TextEditingController();
// //   TextEditingController PasswordController=TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Login page'),),
// //       body: Padding(padding: EdgeInsets.all(20.0),
// //         child: Column(
// //           children: [
// //             TextFormField(
// //               decoration: InputDecoration(labelText: 'Username'),
// //               controller: UsernameController,
// //             ),
// //             TextFormField(
// //               decoration: InputDecoration(labelText: 'Password'),
// //               controller: PasswordController,
// //             ),
// //             ElevatedButton(onPressed: sendData, child: Text('log in')),
// //             TextButton(onPressed: (){
// //               Navigator.push(context, MaterialPageRoute(builder: (context) => AmbulanceRegistration()));
// //             }, child: Text('Ambulance Registration')),
// //             TextButton(onPressed: (){
// //               Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration()));
// //             }, child: Text('User Registration')),
// //           ],
// //         ),),
// //     );
// //   }
// //   Future<void> sendData() async {
// //     String username=UsernameController.text.trim();
// //     String password=PasswordController.text.trim();
// //
// //     if(username.isEmpty||password.isEmpty) {
// //       Fluttertoast.showToast(msg: 'fill the  fields');
// //       return;
// //     }
// //
// //     final sh= await SharedPreferences.getInstance();
// //     String? url= sh.getString('url');
// //
// //     final api=Uri.parse('$url/FlutterLogin/');
// //
// //     try {
// //       final request= await http.post(api,body: {
// //         'username':username,
// //         'password':password,
// //       });
// //
// //       if(request.statusCode == 200) {
// //         var data = jsonDecode(request.body);
// //         if(data['status']=='ok') {
// //           final sh = await SharedPreferences.getInstance();
// //           await sh.setString('lid', data['lid'].toString());
// //           if(data['type'].toString()=="Ambulance") {
// //             Navigator.push(
// //                 context, MaterialPageRoute(builder: (context) => AmbulanceHome()));
// //           }
// //           else if(data['type'].toString()=="User")
// //            {
// //             Navigator.push(
// //                 context, MaterialPageRoute(builder: (context) => UserHome()));
// //           }
// //         }
// //         else {
// //           Fluttertoast.showToast(msg: 'invalid username or password');
// //         }
// //       }
// //       else {
// //         Fluttertoast.showToast(msg: 'connection error');
// //       }
// //
// //     }catch (e){
// //       Fluttertoast.showToast(msg: 'error:$e');
// //     }
// //
// //   }
// // }
//
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
// // import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//
//   final Location _location = Location();
//
//   double? latitude;
//   double? longitude;
//   String status = "Press button to get location";
//
//
//   TextEditingController UsernameController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Page'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//
//             TextFormField(
//               controller: UsernameController,
//               decoration: const InputDecoration(
//                 labelText: 'Username',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             TextFormField(
//               controller: PasswordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: sendData,
//               child: const Text('Login'),
//             ),
//
//             const SizedBox(height: 10),
//
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AmbulanceRegistration()));
//               },
//               child: const Text('Ambulance Registration'),
//             ),
//
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => UserRegistration()));
//               },
//               child: const Text('User Registration'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 Get Current Location
//   // Future<Position> _getCurrentLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       throw 'Location permission denied';
//   //     }
//   //   }
//   //
//   //   if (permission == LocationPermission.deniedForever) {
//   //     throw 'Location permission permanently denied';
//   //   }
//   //
//   //   return await Geolocator.getCurrentPosition(
//   //     desiredAccuracy: LocationAccuracy.high,
//   //   );
//   // }
//
//   /// 🔹 Login + Update Latitude & Longitude
//   Future<void> sendData() async {
//
//     String username = UsernameController.text.trim();
//     String password = PasswordController.text.trim();
//
//     if (username.isEmpty || password.isEmpty) {
//       Fluttertoast.showToast(msg: 'Fill all fields');
//       return;
//     }
//
//     try {
//
//
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
//       // 3️⃣ Get location
//       LocationData locationData = await _location.getLocation();
//
//       setState(() {
//         latitude = locationData.latitude;
//         longitude = locationData.longitude;
//         status = "Location fetched successfully";
//       });
//
//
//       print(status);
//       print("status");
//
//       // Position position = await _getCurrentLocation();
//       // String latitude = position.latitude.toString();
//       // String longitude = position.longitude.toString();
//
//       final sh = await SharedPreferences.getInstance();
//       String? url = sh.getString('url');
//
//       sh.setString("latitude", latitude.toString());
//       sh.setString("longitude", longitude.toString());
//
//       final api = Uri.parse('$url/FlutterLogin/');
//
//       final response = await http.post(api, body: {
//         'username': username,
//         'password': password,
//         'latitude': latitude.toString(),
//         'longitude': longitude.toString(),
//       });
//
//       if (response.statusCode == 200) {
//
//         var data = jsonDecode(response.body);
//
//         if (data['status'] == 'ok') {
//
//           await sh.setString('lid', data['lid'].toString());
//
//           if (data['type'] == "Ambulance") {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AmbulanceHome()),
//             );
//           }
//           else if (data['type'] == "User") {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => UserHome()),
//             );
//           }
//         }
//         else {
//           Fluttertoast.showToast(msg: 'Invalid username or password');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Server connection error');
//       }
//     }
//     catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//     }
//   }
// }



import 'dart:convert';
import 'package:ad_app_tm/ambulance/ambulance_home.dart';
import 'package:ad_app_tm/ambulance/ambulance_registartion.dart';
import 'package:ad_app_tm/forgot_password.dart';
import 'package:ad_app_tm/user/user_home.dart';
import 'package:ad_app_tm/user/user_registration.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final Location _location = Location();
  final _formKey = GlobalKey<FormState>();

  double? latitude;
  double? longitude;
  String status = "Waiting for location...";
  bool _isLoading = false;
  bool _obscurePassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[700]!,
              Colors.red[900]!,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and Title Section
                      _buildHeader(),

                      const SizedBox(height: 40),

                      // Login Form Card
                      _buildLoginCard(),

                      const SizedBox(height: 30),

                      // Registration Options
                      _buildRegistrationSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Emergency Icon with Animation
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.emergency,
            size: 60,
            color: Colors.red[700],
          ),
        ),

        const SizedBox(height: 20),

        // App Title
        const Text(
          "Accident Detection",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Emergency Response System",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Login Title
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              "Access your emergency dashboard",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Username Field
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person_outline, color: Colors.red[700]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[700]!, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Password Field
            TextFormField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline, color: Colors.red[700]),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[700]!, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            // Login Button
            _isLoading
                ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red[700]!),
              ),
            )
                : ElevatedButton(
              onPressed: sendData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationSection() {
    return Column(
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ambulance Registration
            Expanded(
              child: _buildRegistrationButton(
                "Ambulance",
                Icons.local_hospital,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmbulanceRegistration(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 15),
            // User Registration
            Expanded(
              child: _buildRegistrationButton(
                "User",
                Icons.person_add,
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRegistration(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));

        }, child: Text("Forgot Password?",style: TextStyle(color: Colors.grey),))

      ],
    );
  }

  Widget _buildRegistrationButton(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              "Register as",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get Location
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          setState(() => status = "Location service disabled");
          Fluttertoast.showToast(
            msg: "Please enable location services",
            backgroundColor: Colors.orange,
          );
          return;
        }
      }

      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != PermissionStatus.granted) {
          setState(() => status = "Location permission denied");
          Fluttertoast.showToast(
            msg: "Location permission is required",
            backgroundColor: Colors.orange,
          );
          return;
        }
      }

      LocationData locationData = await _location.getLocation();

      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        status = "Location acquired";
      });
    } catch (e) {
      setState(() => status = "Location error: $e");
      Fluttertoast.showToast(
        msg: "Failed to get location",
        backgroundColor: Colors.red,
      );
    }
  }

  // Login Function
  Future<void> sendData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    setState(() => _isLoading = true);

    try {
      // Get location first
      await getCurrentLocation();

      if (latitude == null || longitude == null) {
        Fluttertoast.showToast(
          msg: "Unable to get location. Please try again.",
          backgroundColor: Colors.orange,
        );
        setState(() => _isLoading = false);
        return;
      }

      final sh = await SharedPreferences.getInstance();
      String? url = sh.getString('url');

      if (url == null || url.isEmpty) {
        Fluttertoast.showToast(
          msg: "Server URL not configured",
          backgroundColor: Colors.red,
        );
        setState(() => _isLoading = false);
        return;
      }

      // Save location to SharedPreferences
      await sh.setString("latitude", latitude.toString());
      await sh.setString("longitude", longitude.toString());

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

          // Store user name if available
          if (data['name'] != null) {
            await sh.setString('name', data['name'].toString());
          }

          Fluttertoast.showToast(
            msg: "Login successful!",
            backgroundColor: Colors.green,
          );

          // Navigate based on user type
          if (data['type'] == "Ambulance") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AmbulanceHome()),
            );
          } else if (data['type'] == "User") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserHome()),
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: data['message'] ?? 'Invalid username or password',
            backgroundColor: Colors.red,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Server connection error (${response.statusCode})',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Login error: $e");
      Fluttertoast.showToast(
        msg: 'Error: ${e.toString()}',
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}