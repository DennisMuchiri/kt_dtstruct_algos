
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String token;
  final String userId;
  final String username;

  User({
    this.id,
    this.email,
    this.token,
    this.userId,
    this.username
  });

  factory User.fromJson(Map<String,dynamic> data) => User(
    id: data['id'],
    email: data['email'],
    token: data['token'],
    userId: data['userId'].toString(),
    username: data['username'].toString()
  );

  factory User.fromMap(Map<String,dynamic> map) => User(
      userId : map['userId'],
      token : map['token'],
      id : map['id'],
  email : map['email'],
    username : map['username'],
  );

  Map<String,dynamic> toJson() => {
    "id":this.id,
    "email": this.email,
    "username": this.username,
    "token": this.token,
    "userId": this.userId
  };

  @override
  List<Object> get props => [id,email,token,userId, username];
}

class UserLogin{
  String email;
  String password;

  UserLogin({this.email,this.password});

  Map<String,dynamic> toJson() => {
    "email":this.email,
    "password":this.password
  };
}

class Token {
  String token;
  Token({this.token});

  factory Token.fromJson(Map<String,dynamic> json){
    return Token(
      token: json['token']
    );
  }
}