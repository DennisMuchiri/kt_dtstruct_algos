
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/authentication/dao/authentication_dao.dart';
import 'package:loyaltyapp/authentication/models/authentication_model.dart';
import 'package:loyaltyapp/authentication/models/authentication_response.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';

enum AuthenticationStatus { unknown, authenticated,unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _loginApi = ApiBaseHelper();
  final _authDao = AuthenticationDao();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<dynamic> logIn({
  @required String username,
    @required String password
}) async {
    assert(username != null);
    assert(password != null);

    final _authModel = AuthenticationModel(username, password);
    var response = await _loginApi.getToken(_authModel);
    print(response);
    if (response['code'] == 1 && response['token'] != null && response['token'].toString().isNotEmpty) {
      _controller.add(AuthenticationStatus.authenticated);

      _authDao.deleteUser(0);
      var authResponse = AuthenticationResponse.fromJson(response);
      print("Authentication >");
      print(authResponse.email);
      print(authResponse.username);
      _authDao.createUser(authResponse);
    }else{
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    return response;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}