import 'package:equatable/equatable.dart';

class ContactResponse {
  int totalResults;
  List<Contact> results;
  Contact result;
  Map<String, Contact> result3;

  ContactResponse({this.totalResults, this.results});

  ContactResponse.fromJson(List<dynamic> json) {
    totalResults = json.length; //json['total_results'];

    if (json.isNotEmpty) {
      results = new List<Contact>();
      json.forEach((element) {
        results.add(new Contact.fromJson(element));
      });
    }
  }
}

class Contact {
  String id;
  String county;
  String name;
  String address;
  String telephone;
  String email;
  String website;

  Contact(
      {this.id,
        this.county,
        this.name,
        this.address,
        this.telephone,
        this.email,
        this.website});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    county = json['county'];
    name = json['contact_name'];
    address = json['address'];
    telephone = json['telephone'];
    email = json['email'];
    website = json['website'] as String;
  }

  Map<String, dynamic> toJson() => {
    "county": this.county,
    "contact_name": this.name,
    "address": this.address,
    "telephone": this.telephone,
    "email": this.email,
    "website": this.website
  };
}

