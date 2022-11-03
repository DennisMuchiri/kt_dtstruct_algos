import 'dart:async';

import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/dropdowns/dropdown_items_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class MessageRecipientBloc {
  DropDownRepository _dropDownRepository;
  StreamController _messageRecipientListController;

  StreamSink<ApiResponse<List<MessageRecipient>>> get messageRecipientListSink =>
      _messageRecipientListController.sink;

  Stream<ApiResponse<List<MessageRecipient>>> get messageRecipientListStream =>
      _messageRecipientListController.stream;

  MessageRecipientBloc() {
    _dropDownRepository = DropDownRepository();
    _messageRecipientListController = StreamController<ApiResponse<List<MessageRecipient>>>();

    fetchMessageRecipientList();
  }

  fetchMessageRecipientList() async {
    messageRecipientListSink.add(ApiResponse.loading("Fetching Message Recipients"));
    try {
      List<MessageRecipient> recipients = Set<MessageRecipient>.of(await _dropDownRepository.fetchMessageRecipients()).toList();

      messageRecipientListSink.add(ApiResponse.completed(recipients));
    } catch (e) {
      messageRecipientListSink.add(ApiResponse.error(e.toString()));
    }
  }
  dispose(){
    _messageRecipientListController?.close();
  }
}
