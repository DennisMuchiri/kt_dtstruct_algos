import 'package:loyaltyapp/apiKey.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

import 'contact_model.dart';

/**
 * we fetch the movie list and pass the response in the format
 * described in the MovieResponse class under our models(movie_response.dart)
 */
class ContactRepository extends BaseRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<List<Contact>> fetchContacts() async {
    User user = await getUser();
    final response = await _baseHelper.get("businesscontacts/show",user.token);//campaigns
    print(response);
    return ContactResponse.fromJson(response).results;
  }

  Future<Contact> fetchContact(String id) async {
    User user = await getUser();
    final response = await _baseHelper.get("businesscontacts/view/$id",user.token);

    return Contact.fromJson(response);
  }


  Future<Contact> add(Contact campaign) async {
    User user = await getUser();
    final response = await _baseHelper.post("/contact", campaign.toJson(),user.token);
    print(response);
    return response; //Message.fromJson(response); MessageResponse.fromJson(response).results;
  }
}
