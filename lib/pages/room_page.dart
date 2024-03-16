import 'package:dedsec/providers/login_provider.dart';
import 'package:dedsec/providers/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    final roomprov = context.watch<RoomProvider>();
    final loginprov = context.watch<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(loginprov.homes?[roomprov.index].name ?? ""),
      ),
      body: SafeArea(child: Column()),
    );
  }
}
