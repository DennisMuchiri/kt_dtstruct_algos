
import 'package:equatable/equatable.dart';
import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:meta/meta.dart';

class LoyaltyEventState extends Equatable{

  const LoyaltyEventState();

  @override
  List<Object> get props => [];

}
class LoyaltyEventInitial extends LoyaltyEventState {
  const LoyaltyEventInitial();
}

class LoyaltyEventDetailsLoading extends LoyaltyEventState {}

class LoyaltyEventDetailsLoaded extends LoyaltyEventState {
  final LoyaltyEvent eventDetails;
  const LoyaltyEventDetailsLoaded({@required this.eventDetails}): assert(eventDetails != null);

  @override
  List<Object> get props => [eventDetails];
}

class LoyaltyEventRegistration extends LoyaltyEventState {}

class LoyaltyEventRegistered extends LoyaltyEventState {
  final LoyaltyEventRegistrationResponse eventRegistration;
  const LoyaltyEventRegistered({@required this.eventRegistration}): assert(eventRegistration != null);

  @override
  List<Object> get props => [eventRegistration];
}

class LoyaltyEventCancelRSVP extends LoyaltyEventState {}

class LoyaltyEventRSVPCancelled extends LoyaltyEventState {
  final LoyaltyEventCancelRSVPResponse cancelRSVPResponse;
  const LoyaltyEventRSVPCancelled({@required this.cancelRSVPResponse}): assert(cancelRSVPResponse != null);

  @override
  List<Object> get props => [cancelRSVPResponse];
}

class LoyaltyEventDetailsError extends LoyaltyEventState {
  final String message;
  const LoyaltyEventDetailsError(this.message);
}

class LoyaltyRegistrationError extends LoyaltyEventState {
  final String message;
  const LoyaltyRegistrationError(this.message);
}