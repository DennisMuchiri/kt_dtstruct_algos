import 'package:equatable/equatable.dart';

class LinkResponse {
  int totalResults;
  List<Link> results;
  Link result;
  Map<String, Link> result3;

  LinkResponse({this.totalResults, this.results});

  LinkResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<Link>();
      json.forEach((element) {
        results.add(new Link.fromJson(element));
      });
    }
  }
}

class Link {
  String id;
  String linkName;
  String linkUrl;

  Link(
      {this.id,
        this.linkName,
        this.linkUrl});

  Link.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    linkName = json['link_name'];
    linkUrl = json['link_url'];
  }

  Map<String, dynamic> toJson() => {
    "link_name": this.linkName,
    "link_url": this.linkUrl
  };
}
