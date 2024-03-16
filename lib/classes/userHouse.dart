import 'package:dedsec/classes/user.dart';

class UserHouse {
  String? id;
  String? name;
  List<User>? users;

  UserHouse({
    this.id,
    this.name,
    this.users,
  });

  factory UserHouse.fromJson(Map<String, dynamic> json) {
    return UserHouse(
      id: json['id'],
      name: json['name'],
      users: json['users'],
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
