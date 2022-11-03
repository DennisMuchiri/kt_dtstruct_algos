
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';

class BaseRepository{
  final userDao = UserDao();

  Future<User> getUser() async{
    Map map = await userDao.getUser(0);
    User user = User(userId:  map['userId'].toString(),token: map['token'],email: map['email']);
    return user;
  }
}