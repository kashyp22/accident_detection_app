import 'package:ad_app_tm/user/user_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SendFeedbackPage extends StatefulWidget {
  const SendFeedbackPage({super.key});

  @override
  State<SendFeedbackPage> createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<SendFeedbackPage> {
  int rating = 5;
  final TextEditingController commentsController = TextEditingController();

  Future<void> sendFeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String ip = prefs.getString("url") ?? "";
    String lid = prefs.getString("lid") ?? "";

    var res = await http.post(
      Uri.parse("$ip/send_feedback/"),
      body: {
        "lid": lid,
        "rating": rating.toString(),
        "comments": commentsController.text,
      },
    );
    if(res.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Feedback sent Success")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserHome()),
      );
    }
  }

  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: index < rating ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Rate your experience:", style: TextStyle(fontSize: 16)),
            buildStarRating(), // ⭐ star rating row
            TextField(
              controller: commentsController,
              decoration: const InputDecoration(labelText: "Comments"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendFeedback,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}