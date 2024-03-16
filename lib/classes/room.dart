import 'package:dedsec/classes/device.dart';

class Room {
  String? name;
  List<Device>? devices;

  Room({
    this.name,
    this.devices,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      devices: json['devices'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'devices': devices,
    };
  }
}
