
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/campaign/campaign_repository.dart';
import 'package:rxdart/rxdart.dart';


class CampaignArchivedBlocRx {
  final  CampaignRepository _campaignRepository = CampaignRepository();
  final BehaviorSubject<List<Campaign>> _subjectArchived = BehaviorSubject<List<Campaign>>();

  Stream<List<Campaign>> get archivedCampaignStream => _subjectArchived.stream;

  Future fetchArchivedCampaign() async {
    List<Campaign> campaigns = await _campaignRepository.fetchArchivedCampaigns();
    _subjectArchived.add(campaigns);
  }

  dispose() {
    _subjectArchived.close();
  }

  BehaviorSubject<List<Campaign>> get subjectArchived => _subjectArchived;
}