class PriorityResponse{
  int totalResults;
  List<MessagePriority> results = new List<MessagePriority>();

  PriorityResponse({this.totalResults,this.results});

  PriorityResponse.fromJson(List<dynamic>json){
    totalResults = json.length;
    if(json.isNotEmpty){
      json.forEach((element) {
        results.add(new MessagePriority.fromJson(element));
      });
    }
  }
}

class CountyResponse{
  int totalResults;
  List<County> results = new List<County>();

  CountyResponse({this.totalResults,this.results});

  CountyResponse.fromJson(List<dynamic>json){
    totalResults = json.length;
    if(json.isNotEmpty){
      json.forEach((element) {
        results.add(new County.fromJson(element));
      });
    }
  }
}

class CategoryResponse{
  int totalResults;
  List<Category> results = new List<Category>();

  CategoryResponse({this.totalResults,this.results});

  CategoryResponse.fromJson(List<dynamic>json){
    totalResults = json.length;
    if(json.isNotEmpty){
      json.forEach((element) {
        results.add(new Category.fromJson(element));
      });
    }
  }
}

class MessageRecipientResponse{
  int totalResults;
  List<MessageRecipient> results  = new List<MessageRecipient>();

  MessageRecipientResponse({this.totalResults,this.results});

  MessageRecipientResponse.fromJson(List<dynamic>json){
    totalResults = json.length;
    if(json.isNotEmpty){
      json.forEach((element) {
        var obj = new MessageRecipient.fromJson(element);
        if(!results.any((e) => e.value == obj.value)){
          results.add(obj);
        }
      });
    }
  }
}

class MessagePriority{
  String id;
  String priority;

  MessagePriority({this.id,this.priority});

  MessagePriority.fromJson(Map<String,dynamic>json){
    id = json['id'].toString();
    priority = json['priority'];
  }
}

class Category{
  String id;
  String category;

  Category({this.id,this.category});

  Category.fromJson(Map<String,dynamic>json){
    id = json['id'].toString();
    category = json['category'];
  }
}

class County{
  String id;
  String county;

  County({this.id,this.county});

  County.fromJson(Map<String,dynamic>json){
    id = json['id'].toString();
    county = json['county'];
  }
}

class MessageRecipient {
  String value;
  String display;

  MessageRecipient({this.value,this.display});

  MessageRecipient.fromJson(Map<String,dynamic> json){
    value = json['id'].toString();
    display = json['full_name'] == null ? "" : json['full_name'];
  }
}