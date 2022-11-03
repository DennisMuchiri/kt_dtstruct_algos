import 'dart:async';

import 'package:loyaltyapp/links/link_model.dart';
import 'package:loyaltyapp/links/link_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class LinkDetailBloc {
  LinkRepository _campaignRepository;

  StreamController _campaignDetailController;

  StreamSink<ApiResponse<Link>> get campaignDetailSink =>
      _campaignDetailController.sink;
  Stream<ApiResponse<Link>> get campaignDetailStream =>
      _campaignDetailController.stream;

  LinkDetailBloc(selectedCampaign) {
    _campaignDetailController = StreamController<ApiResponse<Link>>();

    _campaignRepository = LinkRepository();
    fetchLinkDetail(selectedCampaign);
  }

  fetchLinkDetail(String selectedCampaign) async {
    campaignDetailSink.add(ApiResponse.loading("Fetching Details"));
    try {
      Link details =
      await _campaignRepository.fetchLink(selectedCampaign);
      campaignDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      campaignDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _campaignDetailController?.close();
  }
}