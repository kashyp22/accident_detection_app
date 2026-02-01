import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

/// ===============================
/// VIEW PROFILE PAGE - MODERN DESIGN
/// ===============================
class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  bool _loading = true;
  Map<String, dynamic> _data = {};
  String baseUrl = "";
  String img_url = "";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString("url") ?? "";
    img_url = prefs.getString("img_url") ?? "";
    String lid = prefs.getString("lid") ?? "";

    try {
      final response = await http.post(
        Uri.parse(baseUrl + "/userview_profile/"),
        body: {"lid": lid},
      );

      final json = jsonDecode(response.body);
      print(json);

      if (json["status"] == "ok") {
        setState(() {
          _data = {
            "name": json["name"] ?? "",
            "email": json["email"] ?? "",
            "phone": json["phone"] ?? "",
            "pincode": json["pincode"] ?? "",
            "place": json["place"] ?? "",
            "district": json["district"] ?? "",
            "photo_url": json['photo'] ?? "",
          };
          print(_data);
          print("************************");
          _loading = false;
        });
      }
    } catch (e) {
      print("Error loading profile: $e");
      setState(() => _loading = false);
    }
  }

  void _openEdit() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditProfilePage(initialData: _data)),
    );

    if (updated == true) {
      _loadProfile();
    }
  }

  Widget _buildInfoCard(IconData icon, String label, String value, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _loading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF125262)))
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Color(0xFF125262),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Simple pop - goes back to previous screen
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.edit, color: Colors.white, size: 20),
                ),
                onPressed: _openEdit,
              ),
              SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF125262),
                      Color(0xFF1a6d7f),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: _data["photo_url"] != "" &&
                            _data["photo_url"] != null
                            ? NetworkImage(img_url + _data["photo_url"])
                            : null,
                        child: _data["photo_url"] == null ||
                            _data["photo_url"] == ""
                            ? Icon(Icons.person,
                            size: 70, color: Color(0xFF125262))
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      _data["name"] ?? "N/A",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _data["email"] ?? "N/A",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF125262),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard(
                    Icons.phone_outlined,
                    "Phone Number",
                    _data["phone"] ?? "N/A",
                    Colors.blue,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Location Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF125262),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoCard(
                    Icons.location_city_outlined,
                    "Place",
                    _data["place"] ?? "N/A",
                    Colors.green,
                  ),
                  _buildInfoCard(
                    Icons.map_outlined,
                    "District",
                    _data["district"] ?? "N/A",
                    Colors.teal,
                  ),
                  _buildInfoCard(
                    Icons.pin_drop_outlined,
                    "Pincode",
                    _data["pincode"] ?? "N/A",
                    Colors.red,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _openEdit,
      //   backgroundColor: Color(0xFF125262),
      //   icon: Icon(Icons.edit),
      //   label: Text('Edit Profile'),
      // ),
    );
  }
}

/// ===================================================================
/// EDIT PROFILE PAGE
/// ===================================================================

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const EditProfilePage({Key? key, this.initialData}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final place = TextEditingController();
  final district = TextEditingController();
  final pincode = TextEditingController();


  String? photoUrl;
  XFile? newPhoto;

  bool loading = false;
  String baseUrl = "";
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    final d = widget.initialData ?? {};
    name.text = d["name"] ?? "";
    email.text = d["email"] ?? "";
    phone.text = d["phone"] ?? "";
    place.text = d["place"] ?? "";
    district.text = d["district"] ?? "";
    pincode.text = d["pincode"] ?? "";  // Fixed: was "pin"
    photoUrl = d["photo_url"] ?? "";  // Fixed: consistent field name

    loadPrefs();
  }

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString("url") ?? "";
  }

  Future<void> pickPhoto() async {
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => newPhoto = img);
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    final prefs = await SharedPreferences.getInstance();
    String lid = prefs.getString("lid") ?? "";

    try {
      var req = http.MultipartRequest(
        "POST",
        Uri.parse(baseUrl + "/User_updateprofile/"),  // Fixed endpoint
      );

      req.fields["lid"] = lid;
      req.fields["name"] = name.text;
      req.fields["email"] = email.text;
      req.fields["place"] = place.text;
      req.fields["district"] = district.text;
      req.fields["pincode"] = pincode.text;
      req.fields["phone"] = phone.text;

      if (newPhoto != null) {
        File img = File(newPhoto!.path);
        req.files.add(
          await http.MultipartFile.fromPath(
            "photo",
            img.path,
            contentType: MediaType("image", "jpeg"),  // Fixed: was "photo"
          ),
        );
      }

      var response = await req.send();
      var respStr = await http.Response.fromStream(response);
      var body = jsonDecode(respStr.body);

      if (body["status"] == "ok") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Profile updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Update failed: ${body['message'] ?? 'Unknown error'}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => loading = false);
  }

  Widget _imagePreview() {
    if (newPhoto != null) {
      return ClipOval(
        child: Image.file(
          File(newPhoto!.path),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
      );
    }

    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          baseUrl + photoUrl!,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.person, size: 60, color: Colors.white);
          },
        ),
      );
    }
    return Icon(Icons.person, size: 60, color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Color(0xFF125262),  // Fixed: consistent color
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: pickPhoto,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFF125262),
                      child: _imagePreview(),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF125262),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text("Tap to change photo",
                  style: TextStyle(color: Colors.grey)),

              SizedBox(height: 20),

              _input(name, "Full Name", Icons.person),
              SizedBox(height: 15),

              _input(email, "Email", Icons.email,
                  validator: (v) => v!.contains("@") ? null : "Invalid email"),
              SizedBox(height: 15),

              _input(phone, "Phone", Icons.phone,
                  validator: (v) =>
                  v!.length == 10 ? null : "Enter 10 digit number"),
              SizedBox(height: 15),

              _input(place, "Place", Icons.location_city),
              SizedBox(height: 15),

              _input(district, "District", Icons.map),
              SizedBox(height: 15),

              _input(pincode, "Pincode", Icons.pin,
                  validator: (v) =>
                  v!.length == 6 ? null : "Enter 6 digit pincode"),
              SizedBox(height: 15),


              SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: loading ? null : updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF125262),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: loading
                      ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    "Update Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(TextEditingController c, String label, IconData icon,
      {String? Function(String?)? validator}) {
    return TextFormField(
      controller: c,
      validator: validator ??
              (v) {
            if (v!.isEmpty) return "Enter $label";
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF125262), width: 2),
        ),
      ),
    );
  }
}