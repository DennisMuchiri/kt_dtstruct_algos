

import 'package:loyaltyapp/authentication/models/authentication_response.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/database_provider.dart';

class AuthenticationDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(AuthenticationResponse authenticationResponse) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, authenticationResponse.toJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;

    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);

    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;

    try {
      List<Map> users =
      await db.query(userTable, where: 'id = ?', whereArgs: [id]);

      if (users.length > 0 && users.first['token'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
  Future<User> getUser(int id) async {
    final db = await dbProvider.database;
    try{
      var userQuery = await db.query(userTable,where: 'id = ?',whereArgs: [id]);
      return userQuery.map((e) => User.fromJson(e)).toList()[0];
    }catch(e){
      return null;
    }
  }
}
