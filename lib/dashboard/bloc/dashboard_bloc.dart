
import 'dart:async';

import 'package:loyaltyapp/dashboard/dashboard_model.dart';
import 'package:loyaltyapp/dashboard/dashboard_repository.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class DashboardBloc {

  DashboardRepository _dashboardRepository;

  StreamController _dashboardListController;

  StreamSink<ApiResponse<DashboardModel>> get dashboardListSink => _dashboardListController.sink;

  Stream<ApiResponse<DashboardModel>> get dashboardListStream => _dashboardListController.stream;

  DashboardBloc(){
    _dashboardListController = StreamController<ApiResponse<DashboardModel>>();
    _dashboardRepository = DashboardRepository();
    fetchDashboardList();
  }

  fetchDashboardList() async{
    dashboardListSink.add(ApiResponse.loading("Fetching Purchase Data"));
    try{
      DashboardModel dashboardItems = await _dashboardRepository.fetchDashboardItems();
      print(dashboardItems);
      dashboardListSink.add(ApiResponse.completed(dashboardItems));
    }catch(e){
      dashboardListSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose(){
    _dashboardListController?.close();
  }
}