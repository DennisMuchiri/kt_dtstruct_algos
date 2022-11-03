
import 'package:loyaltyapp/notices/notice_model.dart';
import 'package:loyaltyapp/notices/notice_repository.dart';
import 'package:rxdart/rxdart.dart';


class NoticeArchivedBlocRx {
  final  NoticeRepository _noticeRepository = NoticeRepository();
  final BehaviorSubject<List<Notice>> _subjectArchived = BehaviorSubject<List<Notice>>();

  Stream<List<Notice>> get archivedNoticeStream => _subjectArchived.stream;

  Future fetchArchivedNotices() async {
    List<Notice> notices = await _noticeRepository.fetchArchivedNotices();
    _subjectArchived.add(notices);
  }

  dispose() {
    _subjectArchived.close();
  }

  BehaviorSubject<List<Notice>> get subjectArchived => _subjectArchived;
}