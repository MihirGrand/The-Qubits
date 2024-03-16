import 'package:dedsec/constants.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinHousePage extends StatefulWidget {
  const JoinHousePage({super.key});

  @override
  State<JoinHousePage> createState() => _JoinHousePageState();
}

class _JoinHousePageState extends State<JoinHousePage> {
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
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 80),
              Column(
                children: [
                  Text("You have not joined any homes"),
                  const SizedBox(height: 30),
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
                              /*final headers = {
                                'Content-Type': 'application/json'
                              };
                              //Navigator.pushNamed(context, '/home');
                              var response = await client.post(
                                Uri.parse('$uri/api/login'),
                                body: jsonEncode({
                                  'email': email.text,
                                  'password': password.text,
                                }),
                                headers: headers,
                              );
                              if (response.statusCode == 200) {
                                var decodedResponse =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                        as Map;
                                User user =
                                    User.fromJson(decodedResponse['user']);
                                Navigator.pushNamed(context, '/home');
                                loginprov.setUser(user);
                                var homes = await client.get(
                                  Uri.parse('$uri/api/getHouse/${user.id}'),
                                );
                                var res =
                                    jsonDecode(utf8.decode(homes.bodyBytes))
                                        as Map;
                                print(res);
                                List<dynamic> decoded = res["userHouses"];
                                List<UserHouse> homeys = List<UserHouse>.from(
                                    decoded.map<UserHouse>(
                                        (i) => UserHouse.fromJson(i)));
                                loginprov.setHomes(homeys);
                                inspect(loginprov.homes?.length);
                              } else {
                                inspect(response);
                                var dec =
                                    jsonDecode(utf8.decode(response.bodyBytes))
                                        as Map;
                                SmartDialog.showToast(dec['message']);
                              }*/
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "LOGIN",
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
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Register",
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
