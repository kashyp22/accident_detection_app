import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class AmbulanceViewProfile extends StatefulWidget {
  const AmbulanceViewProfile({super.key});

  @override
  State<AmbulanceViewProfile> createState() => _AmbulanceViewProfileState();
}

class _AmbulanceViewProfileState extends State<AmbulanceViewProfile> {
  String name = "", regNo = "", email = "", phone = "", rc = "", status = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('url');
    String? lid = prefs.getString('lid');

    if (url == null || lid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("URL or LID not found in SharedPreferences")),
      );
      return;
    }

    final api = Uri.parse('$url/ambulance_view_profile/');

    try {
      final response = await http.post(api, body: {'lid': lid});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          var profile = data['data'];
          setState(() {
            name = profile['name'];
            regNo = profile['reg_no'];
            status = profile['status'];
            phone = profile['phone'].toString();
            email = profile['email'];
            rc = profile['rc'];
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: rc.isNotEmpty ? NetworkImage(rc) : null,
                    child: rc.isEmpty ? Icon(Icons.person, size: 50) : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Reg No: $regNo",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Profile details
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text("Phone"),
                subtitle: Text(phone),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.redAccent),
                title: Text("Email"),
                subtitle: Text(email),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.verified, color: Colors.blue),
                title: Text("Status"),
                subtitle: Text(status),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AmbulanceEditProfile()),
                // );
              },
              icon: Icon(Icons.edit),
              label: Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}