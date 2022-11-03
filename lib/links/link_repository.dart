import 'package:loyaltyapp/apiKey.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

import 'link_model.dart';

/**
 * we fetch the movie list and pass the response in the format
 * described in the MovieResponse class under our models(movie_response.dart)
 */
class LinkRepository extends BaseRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<List<Link>> fetchLinks() async {
    User user = await getUser();
    final response = await _baseHelper.get("businesslinks/index",user.token);//campaigns /${user.userId}
    return LinkResponse.fromJson(response).results;
  }

  Future<Link> fetchLink(String id) async {
    User user = await getUser();
    final response = await _baseHelper.get("businesslinks/view/$id",user.token);

    return Link.fromJson(response);
  }


  Future<Link> add(Link link) async {
    User user = await getUser();
    final response = await _baseHelper.post("/campaign", link.toJson(),user.token);
    print(response);
    return response; //Message.fromJson(response); MessageResponse.fromJson(response).results;
  }
}
