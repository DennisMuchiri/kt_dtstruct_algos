import 'package:loyaltyapp/login/models/forgotpassword.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

class LoginRepository extends BaseRepository {

  ApiBaseHelper _api = ApiBaseHelper();
  final userDao = UserDao();

  Future<ForgotPasswordResponse> sbtForgotPassword(ForgotPassword forgotPassword) async {
    //User user = await getUser();
    var response = await _api.forgotPassword(forgotPassword.toJson(), "");

    return ForgotPasswordResponse
        .fromJson(response);
  }
}