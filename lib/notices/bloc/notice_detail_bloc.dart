import 'dart:async';

import 'package:loyaltyapp/notices/notice_model.dart';
import 'package:loyaltyapp/notices/notice_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class NoticeDetailBloc {
  NoticeRepository _campaignRepository;

  StreamController _campaignDetailController;

  StreamSink<ApiResponse<Notice>> get campaignDetailSink =>
      _campaignDetailController.sink;
  Stream<ApiResponse<Notice>> get campaignDetailStream =>
      _campaignDetailController.stream;

  StreamController _campaignDocumentController;

  NoticeDetailBloc(selectedCampaign) {
    _campaignDetailController = StreamController<ApiResponse<Notice>>();

    _campaignRepository = NoticeRepository();
    fetchNoticeDetail(selectedCampaign);
  }

  fetchNoticeDetail(String selectedCampaign) async {
    campaignDetailSink.add(ApiResponse.loading("Fetching Details"));
    try {
      Notice details =
      await _campaignRepository.fetchNotice(selectedCampaign);
      campaignDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      campaignDetailSink.add(ApiResponse.error(e.toString()));
    }
  }


  dispose() {
    _campaignDetailController?.close();
  }
}