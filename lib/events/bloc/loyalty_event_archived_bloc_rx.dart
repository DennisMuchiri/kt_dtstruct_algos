import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';
import 'package:rxdart/rxdart.dart';


class LoyaltyEventArchivedBlocRx {
  final  LoyaltyEventRepository _loyaltyEventRepository = LoyaltyEventRepository();
  final BehaviorSubject<List<LoyaltyEvent>> _subjectArchived = BehaviorSubject<List<LoyaltyEvent>>();

  Stream<List<LoyaltyEvent>> get archivedLoyaltyEventStream => _subjectArchived.stream;

  Future fetchArchivedLoyaltyEvents() async {
    List<LoyaltyEvent> events = await _loyaltyEventRepository.fetchArchivedLoyaltyEvents();
    _subjectArchived.add(events);
  }

  dispose() {
    _subjectArchived.close();
  }

  BehaviorSubject<List<LoyaltyEvent>> get subjectArchived => _subjectArchived;
}