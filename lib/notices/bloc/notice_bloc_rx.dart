
import 'package:loyaltyapp/notices/notice_model.dart';
import 'package:loyaltyapp/notices/notice_repository.dart';
import 'package:loyaltyapp/campaign/campaign_response_2.dart';
import 'package:rxdart/rxdart.dart';

class NoticeBlocRx {
  final  NoticeRepository _noticeRepository = NoticeRepository();
  final BehaviorSubject<List<Notice>> _subject = BehaviorSubject<List<Notice>>();

  Stream<List<Notice>> get noticeStream => _subject.stream;


  Future fetchNotices() async {
    List<Notice> notices = await _noticeRepository.fetchNotices();
    _subject.add(notices);
  }


  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Notice>> get subject => _subject;
}