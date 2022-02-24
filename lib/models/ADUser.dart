import 'dart:convert';

AdUser adUserFromJson(String str) => AdUser.fromJson(json.decode(str));

String adUserToJson(AdUser data) => json.encode(data.toJson());

class AdUser {
  String? username;
  String? password;
  AdUser({
    this.username,
    this.password,
  });

  factory AdUser.fromJson(Map<String, dynamic> json) => AdUser(
    username: json["username"],
    password: json["password"],
  );
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
