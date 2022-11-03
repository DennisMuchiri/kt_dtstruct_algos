
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/campaign/campaign_repository.dart';
import 'package:loyaltyapp/campaign/campaign_response_2.dart';
import 'package:rxdart/rxdart.dart';

class CampaignBlocRx {
  final  CampaignRepository _campaignRepository = CampaignRepository();
  final BehaviorSubject<List<Campaign>> _subject = BehaviorSubject<List<Campaign>>();

  Stream<List<Campaign>> get campaignStream => _subject.stream;


  Future fetchCampaign() async {
    List<Campaign> campaigns = await _campaignRepository.fetchCampaigns();
    _subject.add(campaigns);
  }


  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Campaign>> get subject => _subject;
}