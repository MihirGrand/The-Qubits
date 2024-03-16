import 'dart:convert';
import 'dart:developer';

import 'package:dedsec/classes/user.dart';
import 'package:dedsec/classes/userHouse.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
    final loginprov = context.read<LoginProvider>();
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Dedsec",
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextField(
                controller: password,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await Permission.audio.request();
                  await Permission.microphone.request();
                  await Permission.storage.request();
                  final headers = {'Content-Type': 'application/json'};
                  Navigator.pushNamed(context, '/home');
                  /*var response = await client.post(
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
                  User user = User.fromJson(decodedResponse['user']);
                  if (response.statusCode == 200) {
                    Navigator.pushNamed(context, '/home');
                    loginprov.setUser(user);
                    var homes = await client.get(
                      Uri.parse(
                          'https://2c26-152-58-52-11.ngrok-free.app/api/getHouse/$user'),
                      headers: headers,
                    );
                    var res = jsonDecode(utf8.decode(homes.bodyBytes)) as Map;
                    List<UserHouse> homeys = res["userHouses"]
                        .map((e) => e = UserHouse.fromJson(e))
                        .toList();
                    loginprov.setHomes(homeys);
                  } else {
                    inspect(response);
                  }*/
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.grey[900]),
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
}
