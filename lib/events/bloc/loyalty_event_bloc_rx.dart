import 'package:loyaltyapp/events/loyalty_event_model.dart';
import 'package:loyaltyapp/events/loyalty_event_repository.dart';
import 'package:rxdart/rxdart.dart';


class LoyaltyEventBlocRx {
  final  LoyaltyEventRepository _loyaltyEventRepository = LoyaltyEventRepository();
  final BehaviorSubject<List<LoyaltyEvent>> _subject = BehaviorSubject<List<LoyaltyEvent>>();

  Stream<List<LoyaltyEvent>> get loyaltyEventStream => _subject.stream;

  Future fetchLoyaltyEvents() async {
    List<LoyaltyEvent> events = await _loyaltyEventRepository.fetchLoyaltyEvents();
    _subject.add(events);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<LoyaltyEvent>> get subjectArchived => _subject;
}