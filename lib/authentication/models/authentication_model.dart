
import 'package:equatable/equatable.dart';

class AuthenticationModel extends Equatable {
  const AuthenticationModel(this.username, this.password);

  final String username;
  final String password;

  @override
  List<Object> get props => [username,password];

  Map<String,dynamic> toJson() => {
    "email":this.username,
    "password":this.password
  };
}