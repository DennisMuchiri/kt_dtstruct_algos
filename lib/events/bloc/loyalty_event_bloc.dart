import 'dart:async';

import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class LoyaltyEventBloc {
  LoyaltyEventRepository _loyaltyEventRepository;
  StreamController _loyaltyEventListController;
  StreamSink<ApiResponse<List<LoyaltyEvent>>> get loyaltyEventListSink =>
      _loyaltyEventListController.sink;
  Stream<ApiResponse<List<LoyaltyEvent>>> get loyaltyEventListStream =>
      _loyaltyEventListController.stream;

  LoyaltyEventBloc() {
    _loyaltyEventListController =
        StreamController<ApiResponse<List<LoyaltyEvent>>>();
    _loyaltyEventRepository = LoyaltyEventRepository();

    fetchLoyaltyEventList();
  }

  fetchLoyaltyEventList() async {
    loyaltyEventListSink.add(ApiResponse.loading("Fetching Events"));
    try {
      List<LoyaltyEvent> events =
          await _loyaltyEventRepository.fetchLoyaltyEvents();
      loyaltyEventListSink.add(ApiResponse.completed(events));
    } catch (e) {
      loyaltyEventListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _loyaltyEventListController?.close();
  }
}
