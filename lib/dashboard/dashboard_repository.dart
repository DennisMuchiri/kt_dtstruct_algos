
import 'package:loyaltyapp/dashboard/dashboard_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

class DashboardRepository extends BaseRepository{
  ApiBaseHelper _api = ApiBaseHelper();

  Future<DashboardModel> fetchDashboardItems () async{
    User user = await getUser();
    var response = await _api.get("api/home/mobile/${user.userId}",user.token);
    var referrals = await _api.get("api/installers/referrals/${user.userId}", user.token);
    // List<DashboardModel>();// response.add(new DashboardModel(id: "1",item: "item 1",date: "19-11-2020"));
    return DashboardModel.fromJson(response,referrals);//.fromJson(response).results;
  }

  /*Future<List<DashboardModel>> testData()async {

  }*/
}