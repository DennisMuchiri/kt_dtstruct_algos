
import 'dart:async';

import 'package:loyaltyapp/dropdowns/dropdown_item_model.dart';
import 'package:loyaltyapp/dropdowns/dropdown_items_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';


class CategoryBloc{
  StreamController _categoryListController;
  DropDownRepository _dropDownRepository;

  StreamSink<ApiResponse<List<Category>>> get categoryListSink => _categoryListController.sink;

  Stream<ApiResponse<List<Category>>> get categoryListStream => _categoryListController.stream;

  CategoryBloc(){
    _dropDownRepository = DropDownRepository();
    _categoryListController = StreamController<ApiResponse<List<Category>>>();

    fetchCategoryList();
  }

  fetchCategoryList() async {
    categoryListSink.add(ApiResponse.loading("Fetching Categories"));
    try{
      List<Category> categories = await _dropDownRepository.fetchCategories();
      categoryListSink.add(ApiResponse.completed(categories));
    }catch(e){
      categoryListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose(){
    _categoryListController?.close();
  }
}