import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/campaign/campaign_repository.dart';
import 'package:loyaltyapp/campaign/campaign_response_2.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

part 'campaign_event.dart';
part 'campaign_state.dart';
/*
class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository campaignRepository;

  CampaignBloc({@required this.campaignRepository})
      : assert(campaignRepository != null),
        super(CampaignEmpty());

  @override
  Stream<CampaignState> mapEventToState(CampaignEvent event) async* {
    if (event is FetchCampaigns) {
      yield CampaignLoading();
      try {
        final List<Campaign> campaigns =
            await campaignRepository.fetchCampaigns();
        yield CampaignLoaded(campaignModel: campaigns);
      } catch (_) {
        yield CampaignError();
      }
    }
  }
}
*/


class CampaignBloc {
  CampaignRepository _campaignRepository;
  //UserRepository _userRepository;

  StreamController _campaignListController;

  StreamSink<ApiResponse<List<Campaign>>> get campaignListSink =>
      _campaignListController.sink;

  Stream<ApiResponse<List<Campaign>>> get campaignListStream =>
      _campaignListController.stream;


  StreamController _archivedCampaignListController;

  StreamSink<ApiResponse<List<Campaign>>> get archivedCampaignListSink =>
      _archivedCampaignListController.sink;

  Stream<ApiResponse<List<Campaign>>> get archivedCampaignListStream =>
      _archivedCampaignListController.stream;

  CampaignBloc() {
    _campaignListController = StreamController<ApiResponse<List<Campaign>>>.broadcast();
    _archivedCampaignListController = StreamController<ApiResponse<List<Campaign>>>();
    _campaignRepository = CampaignRepository();
    fetchCampaignList();
    fetchArchivedCampaignList();
  }

  fetchCampaignList() async {
    campaignListSink.add(ApiResponse.loading("Fetching Campaigns"));
    try {
      List<Campaign> campaigns = await _campaignRepository.fetchCampaigns();
      campaignListSink.add(ApiResponse.completed(campaigns));
    } catch (e) {
      campaignListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchArchivedCampaignList() async {
    archivedCampaignListSink.add(ApiResponse.loading("Fetching Archived Campaigns"));
    try {
      List<Campaign> campaigns = await _campaignRepository.fetchCampaigns();
      print('archived');
      archivedCampaignListSink.add(ApiResponse.completed(campaigns));
    } catch (e) {
      archivedCampaignListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  addCampaign(Campaign campaign)async {
    ApiResponse.loading("Saving Campaign");
    try{
      var response = await _campaignRepository.add(campaign);
      ApiResponse.completed(response);
    }catch(e){
      ApiResponse.error(e.toString());
    }
  }

  dispose() {
    _campaignListController?.close();
  }
}