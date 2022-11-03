
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/database_provider.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toJson());
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
  Future<Map<String,dynamic>> getUser(int id) async {
    final db = await dbProvider.database;
    try{
      var userQuery = await db.query(userTable,where: 'id = ?',whereArgs: [id],limit: 1);
      if (userQuery.length > 0) {
        return userQuery.first;//User.fromMap(userQuery.first);// userQuery.map((e) => null);
      }
      return null;
    }catch(e){
      return null;
    }
  }
}
