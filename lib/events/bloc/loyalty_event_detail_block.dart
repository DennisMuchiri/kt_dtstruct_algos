import 'dart:async';

import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class LoyaltyEventDetailBloc {
  LoyaltyEventRepository _loyaltyEventRepository;

  StreamController _loyaltyEventDetailController;
  StreamController _loyaltyEventRegistrationController;

  StreamSink<ApiResponse<LoyaltyEvent>> get loyaltyEventDetailSink => _loyaltyEventDetailController.sink;

  Stream<ApiResponse<LoyaltyEvent>> get loyaltyEventDetailStream  => _loyaltyEventDetailController.stream;

  StreamSink<ApiResponse<LoyaltyEventRegistrationResponse>> get loyaltyEventRegistrationSink => _loyaltyEventRegistrationController.sink;

  Stream<ApiResponse<LoyaltyEventRegistrationResponse>> get loyaltyEventRegistrationStream  => _loyaltyEventRegistrationController.stream;


  LoyaltyEventDetailBloc(String selectedEvent){
    _loyaltyEventDetailController = StreamController<ApiResponse<LoyaltyEvent>>();
    _loyaltyEventRegistrationController = StreamController<ApiResponse<LoyaltyEventRegistrationResponse>>();
    _loyaltyEventRepository = LoyaltyEventRepository(); 

    fetchLoyaltyEventDetail(selectedEvent);
  }

  fetchLoyaltyEventDetail(String selectedEvent)async {
    loyaltyEventDetailSink.add(ApiResponse.loading("Fetching Details"));

    try{
      LoyaltyEvent event = await _loyaltyEventRepository.fetchLoyaltyEvent(selectedEvent);
      loyaltyEventDetailSink.add(ApiResponse.completed(event));
    }catch(e){
      loyaltyEventDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  registerLoyaltyEvent(String id) async {
    loyaltyEventRegistrationSink.add(ApiResponse.loading("Registering Event"));

    try{
      LoyaltyEventRegistrationResponse registration = await _loyaltyEventRepository.registerLoyaltyEvent(id);
      loyaltyEventRegistrationSink.add(ApiResponse.completed(registration));
    }catch(e){
      loyaltyEventRegistrationSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose(){
    _loyaltyEventDetailController?.close();
    _loyaltyEventRegistrationController?.close();
  }
}
