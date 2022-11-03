
class ForgotPassword{
  String email;
  ForgotPassword({this.email});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
    "email": this.email
  };
}

class ForgotPasswordResponse {
  String text;
  String type;
  String code;
  ForgotPasswordResponse({this.text, this.code, this.type});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    code = json['code'].toString();
  }

}