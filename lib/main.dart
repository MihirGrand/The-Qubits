import 'package:dedsec/pages/home_page.dart';
import 'package:dedsec/pages/intro_page.dart';
import 'package:dedsec/pages/login_page.dart';
import 'package:dedsec/pages/register_page.dart';
import 'package:dedsec/pages/room_page.dart';
import 'package:dedsec/pages/zego_page.dart';
import 'package:dedsec/providers/audio_provider.dart';
import 'package:dedsec/providers/intro_provider.dart';
import 'package:dedsec/providers/login_provider.dart';
import 'package:dedsec/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntroProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(create: (context) => RoomProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DedSec',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3498DB)),
        useMaterial3: true,
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      debugShowCheckedModeBanner: false,
      /*home: const LoginPage(),
      initialRoute: '/intro',*/
      home: const ZegoPage(),
      routes: {
        '/intro': (context) => const IntroductionPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/room': (context) => const RoomPage(),
      },
    );
  }
}
