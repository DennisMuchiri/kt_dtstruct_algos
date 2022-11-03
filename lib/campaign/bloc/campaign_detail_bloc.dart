import 'dart:async';

import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/campaign/campaign_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class CampaignDetailBloc {
  CampaignRepository _campaignRepository;

  StreamController _campaignDetailController;

  StreamSink<ApiResponse<Campaign>> get campaignDetailSink =>
      _campaignDetailController.sink;
  Stream<ApiResponse<Campaign>> get campaignDetailStream =>
      _campaignDetailController.stream;

  StreamController _campaignDocumentController;

  StreamSink<ApiResponse<List<CampaignDocument>>> get campaignDocumentSink =>
      _campaignDocumentController.sink;
  Stream<ApiResponse<List<CampaignDocument>>> get campaignDocumentStream =>
      _campaignDocumentController.stream;

  CampaignDetailBloc(selectedCampaign) {
    _campaignDetailController = StreamController<ApiResponse<Campaign>>();
    _campaignDocumentController = StreamController<ApiResponse<List<CampaignDocument>>>();

    _campaignRepository = CampaignRepository();
    fetchCampaignDetail(selectedCampaign);
    fetchCampaignDocuments(selectedCampaign);
  }

  fetchCampaignDetail(String selectedCampaign) async {
    campaignDetailSink.add(ApiResponse.loading("Fetching Details"));
    try {
      Campaign details =
      await _campaignRepository.fetchCampaign(selectedCampaign);
      campaignDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      campaignDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  fetchCampaignDocuments(String selectedCampaign) async {
    campaignDocumentSink.add(ApiResponse.loading("Fetching Documents"));
    try {
      List<CampaignDocument> details =
      await _campaignRepository.fetchCampaignDocuments(selectedCampaign);
      campaignDocumentSink.add(ApiResponse.completed(details));
    } catch (e) {
      campaignDocumentSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _campaignDetailController?.close();
    _campaignDocumentController?.close();
  }
}