import 'package:flutter/material.dart';
import 'package:loyaltyapp/user/user_repository.dart';
import 'app.dart';
import 'authentication/authentication_repository.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}