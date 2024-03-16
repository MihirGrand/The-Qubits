import 'package:dedsec/classes/device.dart';

class Room {
  String? name;
  List<Device>? devices;

  Room({
    this.name,
    this.devices,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    List<Device> devicez = [];
    if (json['devices'] == null) {
      devicez = [];
    } else {
      devicez =
          json['devices'].map<Device>((e) => e = Device.fromJson(e)).toList();
    }
    return Room(
      name: json['name'],
      devices: devicez,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'devices': devices,
    };
  }
}
