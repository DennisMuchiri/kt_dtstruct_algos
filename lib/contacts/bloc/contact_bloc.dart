import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/contacts/contact_repository.dart';
import 'package:loyaltyapp/contacts/contact_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc {
  ContactRepository _campaignRepository;
  //UserRepository _userRepository;

  StreamController _campaignListController;

  StreamSink<ApiResponse<List<Contact>>> get campaignListSink =>
      _campaignListController.sink;

  Stream<ApiResponse<List<Contact>>> get campaignListStream =>
      _campaignListController.stream;

  ContactBloc() {
    _campaignListController = StreamController<ApiResponse<List<Contact>>>();
    _campaignRepository = ContactRepository();
    fetchContactList();
  }

  fetchContactList() async {
    campaignListSink.add(ApiResponse.loading("Fetching Contact"));
    try {
      List<Contact> contacts = await _campaignRepository.fetchContacts();
      campaignListSink.add(ApiResponse.completed(contacts));
    } catch (e) {
      campaignListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  addCampaign(Contact contact)async {
    ApiResponse.loading("Saving Campaign");
    try{
      var response = await _campaignRepository.add(contact);
      ApiResponse.completed(response);
    }catch(e){
      ApiResponse.error(e.toString());
    }
  }

  dispose() {
    _campaignListController?.close();
  }
}