import 'dart:async';

import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/contacts/contact_repository.dart';
import 'package:loyaltyapp/contacts/contact_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';

class ContactDetailBloc {
  ContactRepository _campaignRepository;

  StreamController _campaignDetailController;

  StreamSink<ApiResponse<Contact>> get campaignDetailSink =>
      _campaignDetailController.sink;
  Stream<ApiResponse<Contact>> get campaignDetailStream =>
      _campaignDetailController.stream;

  StreamController _campaignDocumentController;

  ContactDetailBloc(selectedCampaign) {
    _campaignDetailController = StreamController<ApiResponse<Contact>>();

    _campaignRepository = ContactRepository();
    fetchContactDetail(selectedCampaign);
  }

  fetchContactDetail(String selectedCampaign) async {
    campaignDetailSink.add(ApiResponse.loading("Fetching Details"));
    try {
      Contact details =
      await _campaignRepository.fetchContact(selectedCampaign);
      campaignDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      campaignDetailSink.add(ApiResponse.error(e.toString()));
    }
  }


  dispose() {
    _campaignDetailController?.close();
  }
}