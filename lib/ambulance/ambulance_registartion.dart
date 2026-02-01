import 'dart:convert';
import 'dart:io';

import 'package:ad_app_tm/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class AmbulanceRegistration extends StatefulWidget {
  const AmbulanceRegistration({super.key});

  @override
  State<AmbulanceRegistration> createState() => _AmbulanceRegistrationState();
}

class _AmbulanceRegistrationState extends State<AmbulanceRegistration> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  TextEditingController regController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController placeController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AmbulanceRegistration page'),),
      body: Padding(padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextFormField(
                decoration: InputDecoration(labelText: 'Registration No'),
                controller: regController,
              ),


              TextFormField(
                decoration: InputDecoration(labelText: 'name'),
                controller: nameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                controller: phoneController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'place'),
                controller: placeController,
              ),
              _image == null
                  ? const Text("Select Your Vechile RC")
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
              ElevatedButton(onPressed: sendData, child: Text('AmbulanceRegistration'))
            ],
          ),
        ),),
    );
  }
  Future <void> sendData() async {
    String reg=regController.text.trim();
    String email=emailController.text.trim();
    String phone=phoneController.text.trim();
    String name=nameController.text.trim();
    String place=placeController.text.trim();
    String password=passwordController.text.trim();
    String username=usernameController.text.trim();

    if(name.isEmpty||password.isEmpty||place.isEmpty||username.isEmpty) {
      // Fluttertoast.showToast(msg: 'fill out all the fields');
      return;
    }
    final sh=await SharedPreferences.getInstance();
    String? url=sh.getString('url');

    final api=Uri.parse('$url/ambulanceregistration/');

    try {
      final request=await http.MultipartRequest('POST',api);

      request.fields['name'] = name;
      request.fields['reg'] = reg;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['place'] = place;
      request.fields['username'] = username;
      request.fields['password'] = password;

      request.files.add(await http.MultipartFile.fromPath(
        'photo', // must match Django field name in request.FILES['photo']
        _image!.path,
      ));

      var response = await request.send();


      if(response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = jsonDecode(responseData);
        if (data['status'] == 'ok') {
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
