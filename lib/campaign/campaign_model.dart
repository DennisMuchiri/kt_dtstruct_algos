import 'package:equatable/equatable.dart';

class CampaignResponse {
  int totalResults;
  List<Campaign> results;
  Campaign result;
  Map<String, Campaign> result3;

  CampaignResponse({this.totalResults, this.results});

  CampaignResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<Campaign>();
      json.forEach((element) {
        results.add(new Campaign.fromJson(element));
      });
    }
  }
}

class Campaign {
  String id;
  String campaign;
  String startDate;
  String endDate;
  String item;
  String itemDescription;
  String discountType;
  String discountValue;
  String uploadedDocumentPath;

  Campaign(
      {this.id,
        this.campaign,
        this.startDate,
        this.endDate,
        this.item,
        this.itemDescription,
        this.discountType,
        this.discountValue,
        this.uploadedDocumentPath});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    campaign = json['campaign'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    item = json['item'];
    itemDescription = json['item_description'];
    discountType = json['discount_type'] as String;
    discountValue = json['discount_value'];
    uploadedDocumentPath = json['uploaded_document_path'];
  }

  Map<String, dynamic> toJson() => {
    "campaign": this.campaign,
    "start_date": this.startDate,
    "end_date": this.endDate,
    "item": this.item,
    "item_description": this.itemDescription,
    "discount_type": this.discountType,
    "discount_value": this.discountValue
  };
}

class CampaignDocumentResponse{
  int totalResults;
  List<CampaignDocument> results;
  CampaignDocument result;
  Map<String, CampaignDocument> result3;

  CampaignDocumentResponse({this.totalResults, this.results});

  CampaignDocumentResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<CampaignDocument>();
      json.forEach((element) {
        results.add(new CampaignDocument.fromJson(element));
      });
    }
  }
}

class CampaignDocument {
  String title;
  String uploadedDocumentPath;
  String extension;
  String uploadedImage;

  CampaignDocument(
      {this.title,
        this.uploadedDocumentPath,
        this.extension,
        this.uploadedImage});

  CampaignDocument.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    uploadedDocumentPath = json['uploaded_document_path'];
    extension = json['extension'];
    uploadedImage = json['uploaded_image'];
  }
}

