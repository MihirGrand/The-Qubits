import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class ZegoPage extends StatefulWidget {
  const ZegoPage({super.key});

  @override
  State<ZegoPage> createState() => _ZegoPageState();
}

class _ZegoPageState extends State<ZegoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextButton(
            child: Text("Emit SOS"),
            onPressed: () {
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
                              }
            },
          ),
        ],
      ),
    );
  }
}
