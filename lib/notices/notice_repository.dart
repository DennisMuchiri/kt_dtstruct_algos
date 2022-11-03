import 'package:loyaltyapp/apiKey.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

import 'notice_model.dart';

/**
 * we fetch the movie list and pass the response in the format
 * described in the MovieResponse class under our models(movie_response.dart)
 */
class NoticeRepository extends BaseRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<List<Notice>> fetchNotices() async {
    User user = await getUser();
    final response = await _baseHelper.get("notices/show",user.token);//campaigns
    return NoticeResponse.fromJson(response).results;
  }

  Future<List<Notice>> fetchArchivedNotices() async {
    User user = await getUser();
    final response = await _baseHelper.get("notices/archived",user.token);//campaigns
    return NoticeResponse.fromJson(response).results;
  }

  Future<Notice> fetchNotice(String id) async {
    User user = await getUser();
    final response = await _baseHelper.get("notices/view/$id",user.token);

    return Notice.fromJson(response);
  }

  Future<Notice> add(Notice notice) async {
    User user = await getUser();
    final response = await _baseHelper.post("/notice", notice.toJson(),user.token);
    print(response);
    return response; //Message.fromJson(response); MessageResponse.fromJson(response).results;
  }
}
