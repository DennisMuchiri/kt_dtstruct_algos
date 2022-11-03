import 'package:loyaltyapp/apiKey.dart';
import 'package:loyaltyapp/message/message_response.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

class MessageRepository extends BaseRepository {
  final userDao = UserDao();

  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<List<LoyaltyMessage>> fetchMessageList() async {

    //Map map = await userDao.getUser(0);
    //User user = User(userId:  map['userId'].toString(),token: map['token']);
    User user = await getUser();
    final response = await _baseHelper.get("messages/index/${user.userId}",user.token);
    print(response);
    return MessageResponse.fromJson(response).results;
  }

  Future<LoyaltyMessageResponse> postMessage(LoyaltyMessage message) async {
    //Map map = await userDao.getUser(0);
    //User user = User(userId:  map['userId'].toString(),token: map['token']);
    User user = await getUser();
    message.userId = user.userId;
    message.createdBy = user.userId;
//print(message.toJson());
    final response = await _baseHelper.post("messages/add/${user.userId}", message.toJson(),user.token);
    print(response);
    return LoyaltyMessageResponse.fromJson(response);
  }

  Future<LoyaltyMessageResponse> reply(Reply reply) async {
    User user = await getUser();
    reply.userId = user.userId;
    //print(reply.toJson());
    //print(reply.messageId);
    final response = await _baseHelper.post("messages/reply/${reply.messageId}", reply.toJson(), user.token);
    return LoyaltyMessageResponse.fromJson(response);
  }

  Future<List<LoyaltyMessage>> fetchMessageReplies(String msgId) async {

    //Map map = await userDao.getUser(0);
    //User user = User(userId:  map['userId'].toString(),token: map['token']);
    User user = await getUser();
    final response = await _baseHelper.get("messages/replies/${msgId}",user.token);
    print(response);
    return MessageResponse.fromJson(response).results;
  }

  Future<List<MessagePriorities>> fetchPriorities()async {
    User user = await getUser();
    var response = await _baseHelper.get("messagepriorities/index",user.token);
    return MessagePriorities.fromJson(response).priorities;
  }
}
