
import 'dart:convert';

import 'package:loyaltyapp/claim/claim_model.dart';

class DashboardModelResponse{
  int totalResults;
  List<DashboardModel> results;

  DashboardModelResponse({this.results,this.totalResults});

  DashboardModelResponse.fromJson(List<dynamic>json){
    totalResults = json.length;
    if(json.isNotEmpty){
      results = List<DashboardModel>();
      json.forEach((element) {
        //results.add(new DashboardModel.fromJson(element));
      });
    }
  }
}

class DashboardModel{

  String id;
  String item;
  String date;
  int totalReferrals;

  Claims claims;
  Map<String,double> cl = {};
  Map<String,dynamic> cl2;

  DashboardModel({
   this.id,this.item,this.date,this.claims,this.cl,this.cl2,this.totalReferrals
});
  DashboardModel.fromJson(Map<String,dynamic>json,List<dynamic> referrals){
    id = json["id"].toString();
    item  = json["item"].toString();
    date = json["date"].toString();
    claims = json['claims'] != null ? Claims.fromJson(json['claims']) :null;
    totalReferrals = referrals.toList().length ?? 0;
  }
}

class Claims {
  String claimed;
  int claimedCount;

  String approved;
  int approvedCount;

  String rejected;
  int rejectedCount;

  String reversed;
  int reversedCount;

  Claims.fromJson(Map<String,dynamic>json){
    claimedCount = json["claimed"] as int;
    approvedCount  = json["approved"] as int;
    rejectedCount = json["rejected"] as int;
    reversedCount  = json["reversed"] as int;
  }
}