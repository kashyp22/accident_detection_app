// import 'dart:convert';
//
// import 'package:ad_app_tm/ambulance/ambulance_home.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class NewComplaintPage extends StatefulWidget {
//   @override
//   _NewComplaintPageState createState() => _NewComplaintPageState();
// }
//
// class _NewComplaintPageState extends State<NewComplaintPage> {
//   final TextEditingController _complaintController = TextEditingController();
//
//   @override
//   void dispose() {
//     _complaintController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Write a New Complaint"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _complaintController,
//               decoration: InputDecoration(
//                 hintText: "Enter your complaint...",
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final sh = await SharedPreferences.getInstance();
//                 String complaint = _complaintController.text.toString();
//                 // String Passwd=passwordController.text.toString();
//                 String url = sh.getString("url").toString();
//                 String lid = sh.getString("lid").toString();
//                 print("okkkkkkkkkkkkkkkkk");
//                 var data = await http.post(
//                     Uri.parse(url + "/ambulance_send_complaint/"),
//                     body: {'complaint': complaint,
//                       'lid': lid,
//
//                     });
//                 var jasondata = json.decode(data.body);
//                 String status = jasondata['status'].toString();
//                 if (status == "ok") {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => AmbulanceHome()));
//                 }
//                 else {
//                   print("error");
//                 }
//               },
//               child: Text("Submit Complaint"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:ad_app_tm/ambulance/ambulance_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewComplaintPage extends StatefulWidget {
  const NewComplaintPage({super.key});

  @override
  State<NewComplaintPage> createState() => _NewComplaintPageState();
}

class _NewComplaintPageState extends State<NewComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _complaintController = TextEditingController();
  bool isSubmitting = false;

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  Future<void> submitComplaint() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    try {
      final sh = await SharedPreferences.getInstance();
      String complaint = _complaintController.text.trim();
      String url = sh.getString("url") ?? "";
      String lid = sh.getString("lid") ?? "";

      var response = await http.post(
        Uri.parse("$url/ambulance_send_complaint/"),
        body: {
          'complaint': complaint,
          'lid': lid,
        },
      );

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == "ok") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint submitted successfully")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AmbulanceHome()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to submit complaint")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Complaint"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.report_problem,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Write Your Complaint",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _complaintController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Enter your complaint here...",
                        prefixIcon: const Icon(Icons.edit),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Complaint cannot be empty";
                        }
                        if (value.trim().length < 10) {
                          return "Complaint must be at least 10 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isSubmitting ? null : submitComplaint,
                        icon: isSubmitting
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Icon(Icons.send),
                        label: Text(
                          isSubmitting ? "Submitting..." : "Submit Complaint",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
