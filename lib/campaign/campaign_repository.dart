import 'package:dio/dio.dart';
import 'package:loyaltyapp/apiKey.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/campaign/campaign_response_2.dart';
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/utils/BaseRepository.dart';

import 'campaign_model.dart';

/**
 * we fetch the movie list and pass the response in the format
 * described in the MovieResponse class under our models(movie_response.dart)
 */
class CampaignRepository extends BaseRepository {
  final String _apiKey = apiKey;

  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<List<Campaign>> fetchCampaigns() async {
    User user = await getUser();
    final response = await _baseHelper.get("campaigns/show",user.token);//campaigns
    print(response);
    return CampaignResponse.fromJson(response).results;
  }

  Future<List<Campaign>> fetchArchivedCampaigns() async {
    User user = await getUser();
    final response = await _baseHelper.get("campaigns/archived",user.token);//campaigns
    print(response);

    return CampaignResponse.fromJson(response).results;
  }

  Future<Campaign> fetchCampaign(String id) async {
    User user = await getUser();
    final response = await _baseHelper.get("campaigns/view/$id",user.token);

    return Campaign.fromJson(response);
  }

  Future<List<CampaignDocument>> fetchCampaignDocuments(String id) async {
    User user = await getUser();
    final response = await _baseHelper.get("campaigns/uploadedcampaignsdocuments/$id",user.token);

    return CampaignDocumentResponse.fromJson(response).results;
  }

  Future<Campaign> add(Campaign campaign) async {
    User user = await getUser();
    final response = await _baseHelper.post("/campaign", campaign.toJson(),user.token);
    print(response);
    return response; //Message.fromJson(response); MessageResponse.fromJson(response).results;
  }
}
