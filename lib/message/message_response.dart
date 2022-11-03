import 'dart:convert';

class MessageResponse {
  int totalResults;
  List<LoyaltyMessage> results;
  LoyaltyMessage result;

  MessageResponse({this.totalResults, this.results});

  //MessageResponse.fromJson(Map<String,dynamic>json){
  MessageResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<LoyaltyMessage>();
      json.forEach((element) {
        results.add(new LoyaltyMessage.fromJson(element));
      });
    }
  }
}

class LoyaltyMessageResponse {
  Response result;

  LoyaltyMessageResponse.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      print("JSON $json");
      result = new Response.fromJson(json);
    }
  }
}

class Response {
  String code;
  String type;
  String message;

  Response({this.message, this.code, this.type});

  Response.fromJson(Map<String, dynamic> json) {
    print(json['text']);
    code = json['code'].toString();
    message = json['text'];
    type = json['type'];
  }
}

class LoyaltyMessage {
  String sender;
  String date;
  String message;
  List recipients;
  String priority;
  String category;
  String userId;
  String subject;
  String id;
  String createdBy;

  LoyaltyMessage(
      {this.sender,
      this.message,
      this.date,
      this.recipients,
      this.priority,
      this.category,
      this.userId,
      this.subject,this.id, this.createdBy});

  LoyaltyMessage.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    message = json['message'];
    category = json['category'];
    date = json['created_on'];
    id = json['id'].toString();
    subject = json['subject'];
    sender = json['full_name'];
  }

  Map<String, dynamic> toJson() => {
        "priority_id": this.priority,
        "category_id": this.category,
        "message": this.message,
        "recipients": this.recipients.toString(),
        "user_id": this.userId,
        "subject": this.subject,
        "created_by":this.createdBy
      };
}

class Reply {
  String message;
  String userId;
  String messageId;

  Reply({this.message, this.userId, this.messageId});

  Map<String, dynamic> toJson() => {
        "message_id": this.messageId,
        "message": this.message,
        "user_id": this.userId
      };
}

class MessagePriorities{
  String id;
  String priority;
  List<MessagePriorities> priorities = new List<MessagePriorities>();

  MessagePriorities({
    this.id,this.priority
});
  MessagePriorities.fromJson(List<dynamic>json){
    if(json.isNotEmpty && json.length >0){
      json.forEach((element) {
        priorities.add(new MessagePriorities(id: element['id'].toString(),priority: element['priority'].toString()));
      });
    }
  }
}