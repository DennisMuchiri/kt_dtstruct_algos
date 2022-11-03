import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/links/link_repository.dart';
import 'package:loyaltyapp/links/link_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

part 'link_event.dart';
part 'link_state.dart';

class LinkBloc {
  LinkRepository _campaignRepository;
  //UserRepository _userRepository;

  StreamController _campaignListController;

  StreamSink<ApiResponse<List<Link>>> get campaignListSink =>
      _campaignListController.sink;

  Stream<ApiResponse<List<Link>>> get campaignListStream =>
      _campaignListController.stream;

  LinkBloc() {
    _campaignListController = StreamController<ApiResponse<List<Link>>>();
    _campaignRepository = LinkRepository();
    fetchCampaignList();
  }

  fetchCampaignList() async {
    campaignListSink.add(ApiResponse.loading("Fetching Links"));
    try {
      List<Link> campaigns = await _campaignRepository.fetchLinks();
      campaignListSink.add(ApiResponse.completed(campaigns));
    } catch (e) {
      campaignListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  addCampaign(Link link)async {
    ApiResponse.loading("Saving Campaign");
    try{
      var response = await _campaignRepository.add(link);
      ApiResponse.completed(response);
    }catch(e){
      ApiResponse.error(e.toString());
    }
  }

  dispose() {
    _campaignListController?.close();
  }
}