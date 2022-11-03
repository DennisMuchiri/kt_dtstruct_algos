
import 'dart:async';

import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/dropdowns/dropdown_items_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class CountyBloc{
  DropDownRepository _dropDownRepository;
  StreamController _countyListController;

  StreamSink<ApiResponse<List<County>>> get countyListSink => _countyListController.sink;

  Stream<ApiResponse<List<County>>> get countyListStream => _countyListController.stream;

  CountyBloc(){
    _dropDownRepository = DropDownRepository();
    _countyListController = StreamController<ApiResponse<List<County>>>();

    fetchCountyList();
  }

  fetchCountyList() async{
    countyListSink.add(ApiResponse.loading("Fetching Counties"));
    try{
      List<County> counties = await _dropDownRepository.fetchCounties();
      countyListSink.add(ApiResponse.completed(counties));
    }catch(e){
      countyListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose(){
    _countyListController?.close();
  }

}