import 'package:loyaltyapp/campaign/campaign_model.dart';

class CampaignResponse2 {
  List<Campaign> campaigns;
  String error;

  CampaignResponse2(this.campaigns, this.error);

/*  CampaignResponse2.fromJson(Map<String, dynamic> json)
      : campaigns = (json["results"] as List)
      .map((i) => new Campaign.fromJson(i))
      .toList(),
        error = "";*/

  CampaignResponse2.fromJson(List<dynamic> json) {
    //totalResults = json.length; //json['total_results'];
    //campaigns = (json["results"] as List);
    campaigns = new List<Campaign>();
    error = "";
    if (json.isNotEmpty) {
      campaigns = new List<Campaign>();
      json.forEach((element) {
        campaigns.add(new Campaign.fromJson(element));
      });
    }
  }

  CampaignResponse2.withError(String errorValue)
      : campaigns = List(),
        error = errorValue;
}