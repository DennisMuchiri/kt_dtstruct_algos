import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

class ClaimRepository extends BaseRepository {
  ApiBaseHelper _baseHelper = ApiBaseHelper();
  final userDao = UserDao();

  Future<List<Claim>> fetchClaims() async {
    User user = await getUser();
    final response = await _baseHelper.get("claims/index/${user.userId}",user.token);

    print(response);
    return ClaimResponse.fromJson(response).response;
  }

  Future<List<Claim>> filterClaims(ClaimFilter filter) async {
    User user = await getUser();
    final response = await _baseHelper.post("claims/filter",filter.toJson(),user.token);

    return ClaimResponse.fromJson(response).response;
  }

  Future<Claim> fetchClaim(String id) async{
    User user = await getUser();
    final response = await _baseHelper.get("claims/invoice/$id/${user.userId}",user.token);
    final claimsView = await _baseHelper.get("claims/view/$id/${user.userId}",user.token);

    //final claimsView = await _baseHelper.get("claims/view/$id",user.token);
    print(claimsView.toString());
    //final response = await _baseHelper.get("claims/invoice/$id",user.token);
    print(response.toString());
    Claim claim = ClaimDetailsResp.fromJson(response, claimsView).claim;
    return claim;
  }

  Future<List<Claim>> searchClaim(Claim claim) async {
    User user = await getUser();
    Claim cl = Claim(invoiceNumber: claim.invoiceNumber);
    final response = await _baseHelper.post("claims/search", cl.toJsonSearch(),user.token);


    if (response is List) {
      print("List $response");
      return ClaimResponse.fromJson(response).response;
    } else {
      print("Single $response");
      return ClaimResponse.fromJsonSingle(response).response;
    }
  }

  Future<Claim> addClaim(Claim claim) async {
    User user = await getUser();
    Claim cl = Claim(invoiceId: claim.invoiceId, userId: user.userId);
    final response = await _baseHelper.post("claims/add", cl.toJsonAdd(),user.token);
    print(response);
    return Claim.fromJson(response);
  }

  Future<ClaimDisputeReplyResponse> addDispute(ClaimDisputeReply claimDisputeReply) async {
    User user = await getUser();
    final response = await _baseHelper.post("claims/add", claimDisputeReply.toJson(user.userId),user.token);
    print(response);
    return ClaimDisputeReplyResponse.fromJson(response);
  }

  Future<List<ClaimDisputeReply>> fetchReplies(String id) async {
    User user = await getUser();
    //Claim cl = Claim(invoiceId: claim.invoiceId, userId: user.userId);
    final response = await _baseHelper.get("api/claims/viewdisputes/$id/${user.userId}", user.token);
    var replies = response['replies'];
    return ClaimDisputeReplyList.fromJson(replies).response;
  }

  Future<List<ClaimDisputeMessage>> fetchMessages(String id) async {
    User user = await getUser();
    //Claim cl = Claim(invoiceId: claim.invoiceId, userId: user.userId);
    final response = await _baseHelper.get("claims/viewdisputes/$id/${user.userId}", user.token);
    var messages = response['messages'];
    return ClaimDisputeMessageList.fromJson(messages).response;
  }
}
