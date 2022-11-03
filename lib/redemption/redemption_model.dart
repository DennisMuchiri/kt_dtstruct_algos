
class Redemption{

  final String redemptionDate;
  final String installerName;
  final String redemptionType;
  final String amountRedeemed;
  final String comments;
  final String runningBalance;
  final String userId;

  const Redemption({
    this.redemptionDate,
    this.installerName,
    this.redemptionType,
    this.amountRedeemed,
    this.comments,
    this.runningBalance,
    this.userId
});

  @override
  List<Object> get props => [
    redemptionDate, installerName, redemptionType, amountRedeemed, comments, runningBalance,userId
  ];

  factory Redemption.fromJson(Map<String,dynamic>json) => Redemption(
    redemptionDate: json["created_on"],
    installerName:  json["user"],
    redemptionType:  json["redemption_type"],
    amountRedeemed:  json["amount"],
    comments:  json["comments"],
    runningBalance:  json["running_balance"],
  );

  Map<String, dynamic> toJsonSearch() => {
    "redemption_type": this.redemptionType,
  };
  Map<String, dynamic> toJsonAdd() =>
      {"redemption_type": this.redemptionType.toString(), "user_id": this.userId};
}

class RedeemPoint {
  final String amount;
  final String redemptionType;
  final String comments;

  const RedeemPoint({
  this.amount,
    this.redemptionType,
    this.comments
});
  factory RedeemPoint.fromJson(Map<String,dynamic>json) => RedeemPoint(

  );

  Map<String, dynamic> toJson(String userId) =>
      {
        "redemption_type": this.redemptionType.toString(),
        "user_id": userId,
        "amount": this.amount.trim().replaceAll(',', ""),
        "comments":this.comments
      };
}

class RedeemPointResponse {
  final String type;
  final String code;
  final String text;

  const RedeemPointResponse({
    this.text,
    this.code,
    this.type
});
  factory RedeemPointResponse.fromJson(Map<String,dynamic>json) => RedeemPointResponse(
    text: json['text'].toString(),
    code: json['code'].toString(),
    type: json['type'].toString()
  );
}

class RedemptionResponse {
  RedemptionResponse({this.response, this.totalRecords});

  List<Redemption> response;
  int totalRecords;

  RedemptionResponse.fromJson(List<dynamic> json) {
    if (json != null && json.isNotEmpty) {
      totalRecords = json.length;
      response = List<Redemption>();
      json.forEach((element) {

        response.add(new Redemption.fromJson(element));
      });
    }
  }
  RedemptionResponse.fromJsonSingle(Map<String, dynamic> json) {
    response = List<Redemption>();
    if (json != null && json.isNotEmpty) {
      response.add(Redemption.fromJson(json));
    }
  }
}

class RedemptionDetailsResp{
  Redemption redemption;
  RedemptionDetailsResp({this.redemption});

  RedemptionDetailsResp.fromJson(List<dynamic> json,Map<String,dynamic> claimView){
    redemption = new Redemption();
    if(json != null && json.length > 0){
      Map<String,dynamic> map = json[0];
      map.addAll(claimView);
      redemption = Redemption.fromJson(map);
    }
  }
}

class RedemptionBalance {
  String runningBalance;
  RedemptionBalance({this.runningBalance});

  RedemptionBalance.fromJson(Map<String, dynamic> redemption) {
    runningBalance = redemption['running_balance'].toString();
  }

}