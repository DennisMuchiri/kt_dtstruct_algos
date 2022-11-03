import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/notices/notice_repository.dart';
import 'package:loyaltyapp/notices/notice_model.dart';

part 'notice_event.dart';
part 'notice_state.dart';


class NoticeBloc {
  NoticeRepository _campaignRepository;
  //UserRepository _userRepository;

  StreamController _campaignListController;

  StreamSink<ApiResponse<List<Notice>>> get campaignListSink =>
      _campaignListController.sink;

  Stream<ApiResponse<List<Notice>>> get campaignListStream =>
      _campaignListController.stream;

  NoticeBloc() {
    _campaignListController = StreamController<ApiResponse<List<Notice>>>();
    _campaignRepository = NoticeRepository();
    fetchNoticeList();
  }

  fetchNoticeList() async {
    campaignListSink.add(ApiResponse.loading("Fetching Notices"));
    try {
      List<Notice> notices = await _campaignRepository.fetchNotices();
      campaignListSink.add(ApiResponse.completed(notices));
    } catch (e) {
      campaignListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }



  dispose() {
    _campaignListController?.close();
  }
}