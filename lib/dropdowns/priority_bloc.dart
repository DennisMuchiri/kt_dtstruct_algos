import 'dart:async';

import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/dropdowns/dropdown_items_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';


class PriorityBloc {
  DropDownRepository _dropDownRepository;
  StreamController _priorityListController;

  StreamSink<ApiResponse<List<MessagePriority>>> get priorityListSink =>
      _priorityListController.sink;

  Stream<ApiResponse<List<MessagePriority>>> get priorityListStream =>
      _priorityListController.stream;

  PriorityBloc() {
    _dropDownRepository = DropDownRepository();
    _priorityListController = StreamController<ApiResponse<List<MessagePriority>>>();

    fetchPriorityList();
  }

  fetchPriorityList() async {
    priorityListSink.add(ApiResponse.loading("Fetching Priorities"));
    try {
      List<MessagePriority> priorities = await _dropDownRepository.fetchPriorities();
      priorityListSink.add(ApiResponse.completed(priorities));
    } catch (e) {
      priorityListSink.add(ApiResponse.error(e.toString()));
    }
  }
  dispose(){
    _priorityListController?.close();
  }
}
