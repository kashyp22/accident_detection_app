
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../login.dart';
import '../main.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  File? _image;
  final ImagePicker _picker = ImagePicker();


  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController districtController=TextEditingController();
  TextEditingController pincodeController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserRegistration page'),),
      body: Padding(padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Num'),
                controller: phoneController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Place'),
                controller: placeController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'District'),
                controller: districtController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pincode'),
                controller: pincodeController,
              ),
              _image == null
                  ? const Text("Select Profile Pic")
                  : Image.file(_image!, height: 200),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo),
                label: const Text("Pick from Gallery"),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Pick from Camera"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: passwordController,
              ),
              ElevatedButton(onPressed: sendData, child: Text('UserRegistration'))
            ],
          ),
        ),),
    );
  }
  Future <void> sendData() async {
    String name=nameController.text.trim();
    String place=placeController.text.trim();
    String password=passwordController.text.trim();
    String username=usernameController.text.trim();
    String phone=phoneController.text.trim();
    String email=emailController.text.trim();
    String district=districtController.text.trim();
    String pincode=pincodeController.text.trim();

    if(name.isEmpty||password.isEmpty||place.isEmpty||username.isEmpty) {
      // Fluttertoast.showToast(msg: 'fill out all the fields');
      return;
    }
    final sh=await SharedPreferences.getInstance();
    String? url=sh.getString('url');

    final api=Uri.parse('$url/UserRegistration/');

    try {
      final request=await http.MultipartRequest('POST',api);

      request.fields['name'] = name;
      request.fields['place'] = place;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['number'] = phone;
      request.fields['email'] = email;
      request.fields['district'] = district;
      request.fields['pincode'] = pincode;

      request.files.add(await http.MultipartFile.fromPath(
        'photo', // must match Django field name in request.FILES['photo']
        _image!.path,
      ));

      var response = await request.send();


      if(response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        if (data['status'] == 'ok') {
          Fluttertoast.showToast(msg: 'registered successfully');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
        else {
          Fluttertoast.showToast(msg: 'Error Ocuured');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Error Ocuured');
      }
    }
    catch(e){
      Fluttertoast.showToast(msg: 'Error:$e');
    }

  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

}
