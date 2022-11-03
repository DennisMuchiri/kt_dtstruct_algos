
class RegistrationModel {
  String email;
  String password;
  String confirmPassword;
  String firstname;
  String lastname;
  String idNumber;
  String kraPin;
  String referralCode;
  String county;
  String mobileNumber;
  String lat;
  String long;
  String what3words;
  String phoneCode;

  RegistrationModel({
  this.email,
  this.password,
    this.confirmPassword,
  this.county,
  this.firstname,this.lastname,
  this.idNumber,
    this.kraPin,
  this.lat,
  this.long,
  this.mobileNumber,
  this.referralCode,
    this.what3words,
    this.phoneCode
  });

  Map<String, dynamic> toJson() => {
    "email":this.email,
    "reg_password":this.password,
    "first_name":this.firstname,
    "last_name":this.lastname,
    "id_number":this.idNumber,
    "kra_pin":this.kraPin,
    "mobile_number_phoneCode": this.phoneCode,
    "mobile_number":this.mobileNumber.replaceAll(new RegExp(r'[^\w\s]+'),''),
    "referral_code":this.referralCode,
    "county_id":this.county,
   /* "latitude":this.lat,
    "longitude":this.long,
    "what3words":this.what3words*/
  };

}

class RegisterResponse{
  String code;
  String text;
  String type;

  RegisterResponse.fromJson(Map<String,dynamic> json) {
    code = json['code'].toString();
    text = json['text'];
    type = json['type'];
  }
}

class What3WordsResponse{
  String code;
  String text;
  String what3words;

  What3WordsResponse.fromJson(Map<String,dynamic> json) {
    code = json['code'].toString();
    text = json['text'];
    what3words = json['words'];
  }
}
class What3Words{
  String lat;
  String long;

  What3Words({this.lat,this.long});

  Map<String,dynamic> toJson() =>{
    "lat":this.lat,
    "long":this.long
  };
}