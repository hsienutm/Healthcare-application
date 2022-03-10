import 'package:flutter/foundation.dart';

@immutable
class User {
  User({
    required this.phone,
    required this.username,
    required this.email,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          phone: json['phone']! as String,
          email: json['email']! as String,
          username: json['username']! as String,
        );

  final String phone;
  final String username;
  final String email;

  Map<String, Object?> toJson() {
    return {
      'phone': phone,
      'username': username,
      'email': email,
    };
  }
}
