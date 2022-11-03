
import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';


class LoyaltyEventRepository extends BaseRepository {

  ApiBaseHelper _api = ApiBaseHelper();
  final userDao = UserDao();

  Future<List<LoyaltyEvent>> fetchLoyaltyEvents() async{
    User user = await getUser();
    var response = await _api.get("events/show",user.token);

    return LoyaltyEventResponse.fromJson(response).results;
  }

  Future<List<LoyaltyEvent>> fetchArchivedLoyaltyEvents() async {
    User user = await getUser();
    var response = await _api.get("events/archived",user.token);

    return LoyaltyEventResponse.fromJson(response).results;
  }

  Future<LoyaltyEvent> fetchLoyaltyEvent(String id) async {
    User user = await getUser();
    final response = await _api.get("events/view/$id/${user.userId}",user.token);
    print(response);
    return LoyaltyEvent.fromJson(response);
  }

  Future<LoyaltyEventRegistrationResponse> registerLoyaltyEvent(String id) async {
    User user = await getUser();
    final response = await _api.get("events/register/$id/${user.userId}",user.token);
    return LoyaltyEventRegistrationResponse.fromJson(response);
  }

  Future<LoyaltyEventCancelRSVPResponse> cancelRSVP(String id) async {
    User user = await getUser();
    final response = await _api.post("api/events/cancelattendance/$id/${user.userId}", this.toJson(id), user.token); //$id/${user.userId}
    print(response);
    return LoyaltyEventCancelRSVPResponse.fromJson(response);
  }

  Future<List<EventDocument>> fetchEventDocuments(String id) async {
    User user = await getUser();
    final response = await _api.get("events/uploadedcampaignsdocuments/$id",user.token);

    return EventDocumentResponse.fromJson(response).results;
  }

  Map<String, dynamic> toJson(String id) => {
    "id": id,
  };
}
