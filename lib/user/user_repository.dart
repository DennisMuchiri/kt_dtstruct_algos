
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/authentication/dao/authentication_dao.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';


class UserRepository {

  final authenticationDao = AuthenticationDao();
  final apiHelper = ApiBaseHelper();

/*  Future<User> authenticate({@required email, @required password})async {
    AuthenticationModel authenticationModel = AuthenticationModel(email,password);

    Map<String,dynamic> token = await apiHelper.getToken(authenticationModel);
    print(token['token']);
    User user = User("1");// (id: 0,email: email,token: token['token'],userId: token['userId'].toString());

    return user;
  }*/

  Future<void> persistToken({@required User user})async {
    //await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id})async {
    await authenticationDao.deleteUser(id);
  }

  Future<bool> hasToken()async {
    bool result = await authenticationDao.checkUser(0);
    return result;
  }

  Future<User> getUser() async{
    User user = await authenticationDao.getUser(0);
    return user;
  }
}