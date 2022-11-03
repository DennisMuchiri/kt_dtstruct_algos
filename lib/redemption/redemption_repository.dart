
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';
import 'package:loyaltyapp/user/user_dao.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/redemption/redemption_model.dart';

class RedemptionRepository extends BaseRepository {
  ApiBaseHelper _baseHelper = ApiBaseHelper();
  final userDao = UserDao();

  Future<List<Redemption>> fetchRedemptions() async {
    print("Fetching Redemptions");
    User user = await getUser();
    final response = await _baseHelper.get("claims/redemptions/${user.userId}",user.token);

    return RedemptionResponse.fromJson(response).response;
  }

  Future<Redemption> fetchRedemption(String id) async{
    User user = await getUser();
    final response = await _baseHelper.get("claims/invoice/$id/${user.userId}",user.token);
    final claimsView = await _baseHelper.get("claims/view/$id/${user.userId}",user.token);
    //print(claimsView.toString());
    //print(response.toString());
    Redemption redemption = RedemptionDetailsResp.fromJson(response,claimsView).redemption;
    return redemption;
  }

  Future<List<Redemption>> searchRedemption(Redemption redemption) async {
    User user = await getUser();
    Redemption cl = Redemption(redemptionType: redemption.redemptionType);
    final response = await _baseHelper.post("claims/search", cl.toJsonSearch(),user.token);

    print(response);
    if (response is List) {
      return RedemptionResponse.fromJson(response).response;
    } else {
      return RedemptionResponse.fromJsonSingle(response).response;
    }
  }

  Future<Redemption> addRedemption(Redemption redemption) async {
    User user = await getUser();
    Redemption cl = Redemption(redemptionType: redemption.redemptionType,userId: user.userId);
    final response = await _baseHelper.post("claims/add", cl.toJsonAdd(),user.token);
    print(response);
    return Redemption.fromJson(response);
  }

  Future<RedeemPointResponse> redeemPoint(RedeemPoint redeemPoint) async {
    User user = await getUser();
    print(redeemPoint.toJson(user.userId));
    final response = await _baseHelper.post("api/claims/redeem", redeemPoint.toJson(user.userId), user.token);
    print(response);
    return RedeemPointResponse.fromJson(response);
  }

  Future<RedemptionBalance> getBalance() async {
    User user = await getUser();
    //print(redeemPoint.toJson(user.userId));
    final response = await _baseHelper.get("claims/redeem/${user.userId}", user.token);
    print(response);
    return RedemptionBalance.fromJson(response);
  }
}