
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/events/bloc/loyalty_event_state.dart';
import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';


class LoyaltyEventCubit extends Cubit<LoyaltyEventState>{
  final LoyaltyEventRepository loyaltyEventRepository;

  LoyaltyEventCubit(this.loyaltyEventRepository) : super(LoyaltyEventInitial());

  Future<LoyaltyEvent> fetchLoyaltyEventDetail(String selectedEvent)async {
    try{
      emit(LoyaltyEventDetailsLoading());
      LoyaltyEvent event = await loyaltyEventRepository.fetchLoyaltyEvent(selectedEvent);
      emit(LoyaltyEventDetailsLoaded(eventDetails: event));
    }catch(e){
      emit(LoyaltyEventDetailsError(e.toString()));
    }
  }

  Future<LoyaltyEventRegistrationResponse> registerLoyaltyEvent(String id) async {
     try{
       emit(LoyaltyEventRegistration());
      final LoyaltyEventRegistrationResponse registration = await loyaltyEventRepository.registerLoyaltyEvent(id);
      emit(LoyaltyEventRegistered(eventRegistration: registration));
      fetchLoyaltyEventDetail(id);
      return registration;
    }catch(e){
      emit(LoyaltyRegistrationError(e.toString()));
      return e;
    }
  }

  Future<LoyaltyEventCancelRSVPResponse> cancelRSVP(String id) async {
    try {
      //emit(LoyaltyEventCancelRSVP());
      final LoyaltyEventCancelRSVPResponse cancelRSVPResponse = await loyaltyEventRepository.cancelRSVP(id);
      //emit(LoyaltyEventRSVPCancelled(cancelRSVPResponse: cancelRSVPResponse));
      fetchLoyaltyEventDetail(id);
      return cancelRSVPResponse;
    } catch(e) {
      //emit(LoyaltyRegistrationError(e.toString()));
      print(e);
      //return e;
    }
  }
}