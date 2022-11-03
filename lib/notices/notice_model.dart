
class NoticeResponse {
  int totalResults;
  List<Notice> results;
  Notice result;
  Map<String, Notice> result3;

  NoticeResponse({this.totalResults, this.results});

  NoticeResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<Notice>();
      json.forEach((element) {
        results.add(new Notice.fromJson(element));
      });
    }
  }
}

class Notice {
  String id;
  String title;
  String startDate;
  String endDate;
  String description;

  Notice(
      {this.id,
        this.title,
        this.startDate,
        this.endDate,
        this.description});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['notice_title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
    "title": this.title,
    "start_date": this.startDate,
    "end_date": this.endDate,
    "description": this.description
  };
}
