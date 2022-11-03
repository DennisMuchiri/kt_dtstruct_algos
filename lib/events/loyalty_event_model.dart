class LoyaltyEventResponse {
  int totalResults;
  List<LoyaltyEvent> results;

  LoyaltyEventResponse.fromJson(List<dynamic> json) {

    if (json.isNotEmpty) {
      results = new List<LoyaltyEvent>();
      json.forEach((element) {
        results.add(new LoyaltyEvent.fromJson(element));
      });
    } else{
      results = null;//new List<LoyaltyEvent>();
    }
  }
}

class LoyaltyEvent {
  String id;
  String category;
  String certificate;
  String title;
  String startDate;
  String endDate;
  String venue;
  String description;
  String maxAttendance;
  String text;
  int eventRegistration;
  int attendance;

  LoyaltyEvent(
      {this.id,
      this.category,
      this.certificate,
      this.title,
      this.startDate,
      this.endDate,
      this.venue,
      this.description,
      this.maxAttendance,
      this.text,
      this.eventRegistration,
      this.attendance});

  LoyaltyEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    category = json['category'];
    certificate = json['template_name'];
    title = json['event_title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    venue = json['venue'];
    description = json['description'].toString();
    maxAttendance = json['maximum_attendance'].toString();
    eventRegistration = json['event_registration'];
    text = json["text"];
    attendance = json['attendance'];
  }

}

class LoyaltyEventRegistrationResponse{
  String text;
  String code;
  String type;

  LoyaltyEventRegistrationResponse({this.text, this.type, this.code});

  LoyaltyEventRegistrationResponse.fromJson(Map<String,dynamic> json){
    text = json["text"];
    code = json["code"].toString();
    type = json["type"];
  }
}

class LoyaltyEventCancelRSVPResponse{
  String text;
  String code;
  String type;

  LoyaltyEventCancelRSVPResponse({this.text, this.code, this.type});

  LoyaltyEventCancelRSVPResponse.fromJson(Map<String,dynamic> json){
    text = json["text"];
    code = json["code"].toString();
    type = json["type"];
  }
}

class EventDocumentResponse{
  int totalResults;
  List<EventDocument> results;
  EventDocument result;
  Map<String, EventDocument> result3;

  EventDocumentResponse({this.totalResults, this.results});

  EventDocumentResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = List.empty();// new List<CampaignDocument>();
      json.forEach((element) {
        results.add(new EventDocument.fromJson(element));
      });
    }
  }
}

class EventDocument {
  String title;
  String uploadedDocumentPath;
  String extension;
  String uploadedImage;

  EventDocument(
      {this.title,
        this.uploadedDocumentPath,
        this.extension,
        this.uploadedImage});

  EventDocument.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    uploadedDocumentPath = json['uploaded_document_path'];
    extension = json['extension'];
    uploadedImage = json['uploaded_image'];
  }
}
