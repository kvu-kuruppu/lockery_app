import 'package:firebase_auth/firebase_auth.dart' as Firebase show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String? email;

  const AuthUser({
    required this.id,
    required this.email,
  });

  factory AuthUser.fromFirebase(Firebase.User user) => AuthUser(
        id: user.uid,
        email: user.email,
      );
}
