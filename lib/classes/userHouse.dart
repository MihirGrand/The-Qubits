import 'package:dedsec/classes/room.dart';
import 'package:dedsec/classes/user.dart';

class UserHouse {
  String? id;
  String? name;
  List<String>? users;
  List<Room>? rooms;

  UserHouse({this.id, this.name, this.users, this.rooms});

  factory UserHouse.fromJson(Map<String, dynamic> json) {
    return UserHouse(
      id: json['id'],
      name: json['name'],
      users: json['users'].map<String>((data) => data.toString()).toList(),
      rooms: json['rooms'].map<Room>((e) => e = Room.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'users': users,
    };
  }
}
