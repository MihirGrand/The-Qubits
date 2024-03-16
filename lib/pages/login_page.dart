import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var client = http.Client();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Column(
          children: [
            Text("Dedsec"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "email"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: "Password"),
            ),
            TextButton(
              onPressed: () async {
                final headers = {'Content-Type': 'application/json'};
                var response = await client.post(
                  Uri.parse(
                      'https://2c26-152-58-52-11.ngrok-free.app/api/login'),
                  body: jsonEncode({
                    'email': email.text,
                    'password': password.text,
                  }),
                  headers: headers,
                );
                var decodedResponse =
                    jsonDecode(utf8.decode(response.bodyBytes)) as Map;
                print(decodedResponse);
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
