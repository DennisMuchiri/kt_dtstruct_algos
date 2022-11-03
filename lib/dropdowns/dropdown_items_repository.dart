
import 'package:loyaltyapp/authentication/dao/authentication_dao.dart';
import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

class DropDownRepository extends BaseRepository{

  ApiBaseHelper _api = ApiBaseHelper();
  final authDao = AuthenticationDao();

  Future<List<MessagePriority>> fetchPriorities()async {
    User user = await getUser();
    var response = await _api.get("messagepriorities/index",user.token);
    return PriorityResponse.fromJson(response).results;
  }

  Future<List<Category>> fetchCategories()async {
    User user = await getUser();
    var response = await _api.get("messagecategories/index",user.token);
    return CategoryResponse.fromJson(response).results;
  }

  Future<List<County>> fetchCounties()async {
    User user = await getUser();
    var response = await _api.get("counties/index",user.token);
    return CountyResponse.fromJson(response).results;
  }

  Future<List<MessageRecipient>> fetchMessageRecipients() async {
    //var user = authDao.getUser(0);
    User user = await getUser();
    var response = await _api.get("messages/messagerecipients/${user.userId}",user.token);

    return MessageRecipientResponse.fromJson(response).results;
  }
}