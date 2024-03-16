import 'dart:convert';
import 'dart:developer';

import 'package:dedsec/classes/user.dart';
import 'package:dedsec/classes/userHouse.dart';
import 'package:dedsec/constants.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var client = http.Client();
  @override
  Widget build(BuildContext context) {
    final loginprov = context.read<LoginProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: bg,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: bg,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 80),
              Column(
                children: [
                  TextField(
                    controller: name,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: bgS,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: bgS),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: email,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: bgS,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: bgS),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: password,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: bgS,
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: bgS),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme),
                          child: TextButton(
                            onPressed: () async {
                              final headers = {
                                'Content-Type': 'application/json'
                              };
                              var response = await client.post(
                                Uri.parse('$uri/api/register'),
                                body: jsonEncode({
                                  'name': name.text,
                                  'email': email.text,
                                  'password': password.text,
                                }),
                                headers: headers,
                              );
                              if (response.statusCode == 200) {
                                Navigator.pushNamed(context, '/login');
                                SmartDialog.showToast(
                                    "Successfully registered! Please login to continue.");
                              } else {
                                inspect(response);
                                var dec =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                        as Map;
                                SmartDialog.showToast(dec['message']);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: theme,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
