
import 'package:equatable/equatable.dart';

class AuthenticationResponse extends Equatable {

  const AuthenticationResponse(this.id,this.token,this.userId, this.username, this.email);

  final int id;
  final String token;
  final String userId;
  final String username;
  final String email;

  @override
  List<Object> get props => [];

  factory AuthenticationResponse.fromJson(Map<String,dynamic> json){
    print(json);
    return AuthenticationResponse(0, json['token'], json['userId'].toString(), json['username'].toString(), json['email'].toString());
  }

  Map<String,dynamic>toJson() =>{
    "id":this.id,
    "token":this.token,
    "userId":this.userId,
    "email": this.email,
    "username": this.username
  };
}