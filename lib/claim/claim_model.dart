import 'dart:convert';

import 'dart:ffi';

class Claim {
  final String id;
  final String customerName;
  final String invoiceNumber;
  final String order;
  final String status;
  final String dateDiscarded;
  final String invoiceId;
  final String text;
  final String type;
  final String code;
  final String userId;
  final String fullDescription;
  final String createdOn;
  final String actor;
  final String comment;
  final String totalSalesExclVat;
  final String discountedPurchasePrice;
  final String purchasePrice;
  final String salesInclVat;
  final String discounted;
  final String nonDiscounted;
  final String vat;
  final String discount;
  final String discountPercentage;
  final String invoiceAmount;


  const Claim(
      {this.id,
      this.customerName,
      this.invoiceNumber,
      this.order,
      this.status,
      this.dateDiscarded,
      this.invoiceId,
      this.text,
      this.type,
      this.code,
      this.userId,
      this.fullDescription,
      this.createdOn,
      this.actor,this.comment,this.totalSalesExclVat,this.discountedPurchasePrice, this.purchasePrice, this.salesInclVat,
        this.discounted, this.nonDiscounted, this.discountPercentage, this.vat, this.discount, this.invoiceAmount});

  @override
  List<Object> get props => [
        id,
        customerName,
        invoiceNumber,
        order,
        status,
        dateDiscarded,
        text,
        code,
        text,
        createdOn,
    actor,
    comment,
    totalSalesExclVat,
    discountedPurchasePrice, purchasePrice, salesInclVat, discounted, nonDiscounted, vat, salesInclVat, discount, discountPercentage, this.invoiceAmount
      ];


  factory Claim.fromJson(Map<String, dynamic> json) => Claim(
      id: json["id"].toString(),
      customerName: json["customer_name"].toString(),
      invoiceNumber: json["invoice_number"].toString(),
      order: json["order"].toString(),
      status: json["status"].toString(),
      dateDiscarded: json["date_decarded"].toString(),
      invoiceId: json["invoice_id"].toString(),
      fullDescription: json['full_description'],
      text: json['text'].toString(),
      type: json['type'].toString(),
      createdOn: json['created_on'].toString(),
      actor: json['actor'].toString(),
      comment: json['comments'].toString(),
      totalSalesExclVat: json['total_sales_excl_vat'].toString(),
      discountedPurchasePrice: json['discounted_purchase_price'].toString(),
      purchasePrice: json['purchase_price'].toString(),
      code: json['category_code'].toString(),
      salesInclVat: json['sales_incl_vat'].toString(),
    discounted: json['discounted'].toString(),
    nonDiscounted: json['nondiscounted'].toString(),
      vat: json['vat'].toString(),
      //invoiceAmount: json['discounted'].toString().trim().replaceAll(',', "replace")
  );

  Map<String, dynamic> toJson() => {
        "customer_name": this.customerName,
        "invoice_number": this.invoiceNumber,
        "order": this.order,
        "status": this.status,
        "date_decarded": this.dateDiscarded,
        "invoice_id": this.invoiceId
      };
  Map<String, dynamic> toJsonSearch() => {
        "invoice_number": this.invoiceNumber,
      };
  Map<String, dynamic> toJsonAdd() =>
      {
        "invoice_id": this.invoiceId.toString(),
        "user_id": this.userId,
        "created_by": this.userId,
        "created_on": DateTime.now().toString()
      };
}

class ClaimResponse {
  ClaimResponse({this.response, this.totalRecords});
  List<Claim> response;
  int totalRecords;

  ClaimResponse.fromJson(List<dynamic> json) {
    if (json != null && json.isNotEmpty) {
      totalRecords = json.length;
      response = List<Claim>();
      json.forEach((element) {
       response.add(
           new Claim(
              purchasePrice: element['purchase_price'],
             status: element['status'],
             id: element['id'].toString(),
             actor: element['actor'],
             code: element['code'],
             comment: element['comment'],
             createdOn: element['created_on'],
             dateDiscarded: element['date_decarded'],
             order: element['order'],
             fullDescription: element['full_description'],
             text: element['text'],
             totalSalesExclVat: element['total_sales_excl_vat'],
             discountedPurchasePrice: element['discounted_purchase_price'],
             invoiceNumber: element['invoice_number'],
             invoiceId: element['invoice_id'].toString(),
             discounted: element['discounted'].toString(),
             nonDiscounted: element['nondiscounted'].toString(),
             vat: element['vat'].toString(),
             discount: element['total_discount'].toString(),
             discountPercentage: element['discount_percentage'].toString(),
             salesInclVat: element['sales_incl_vat'].toString(),
             customerName: element['customer_name'].toString(),
            invoiceAmount: element['discounted'] == null ? '0' :  (double.parse(element['discounted'].toString().trim().replaceAll(',', "")) + double.parse(element['nondiscounted'].toString().trim().replaceAll(',', ""))).toString()// + double.parse(element['nondiscounted'].toString())
           )
       );
        //response.add(new Claim.fromJson(element));
      });
    }
  }

  ClaimResponse.fromJsonSingle(Map<String, dynamic> json) {
    response = List<Claim>();
    if (json != null && json.isNotEmpty) {
      response.add(Claim.fromJson(json));
    }
  }
}

class ClaimDetailsResp{
  Claim claim;
  ClaimDetailsResp({this.claim});

  ClaimDetailsResp.fromJson(List<dynamic> json, List<dynamic> claimView) {//Map<String,dynamic> claimView
    claim = new Claim();
    if(json != null && json.length > 0){
      Map<String,dynamic> map = json[0];
      map.addAll(claimView[0]);
      claim = Claim.fromJson(map);
    }
  }

}

class ClaimFilter{
 final bool approved;
  final bool pending;
  final bool denied;
  final String date;
const ClaimFilter({this.approved,this.pending,this.denied,this.date});
  Map<String, dynamic> toJson() => {
    "approved": this.approved,
    "pending": this.pending,
    "denied": this.denied,
    "date": this.date,
  };
}

class ClaimDisputeReplyList {
  List<ClaimDisputeReply> response;
  int totalRecords;

  ClaimDisputeReplyList.fromJson(List<dynamic> json) {
    if (json != null && json.isNotEmpty) {
      totalRecords = json.length;
      response = List<ClaimDisputeReply>();
      json.forEach((element) {
        response.add(
            new ClaimDisputeReply(
              message: element['message'],
            )
        );
        //response.add(new Claim.fromJson(element));
      });
    }
  }
}

class ClaimDisputeMessageList {
  List<ClaimDisputeMessage> response;
  int totalRecords;

  ClaimDisputeMessageList.fromJson(List<dynamic> json) {
    if (json != null && json.isNotEmpty) {
      totalRecords = json.length;
      response = List<ClaimDisputeMessage>();
      json.forEach((element) {
        response.add(
            new ClaimDisputeMessage(
              message: element['message'],
            )
        );
        //response.add(new Claim.fromJson(element));
      });
    }
  }
}

class ClaimDisputeReply {
  final String message;
  final String id;
  const ClaimDisputeReply({
    this.message,
    this.id
});
  Map<String, dynamic> toJson(String userId) =>
      {
        "message": this.message.toString(),
        "user_id": userId,
        "invoice_id":this.id
      };
}

class ClaimDisputeMessage {
  final String message;
  final String id;
  const ClaimDisputeMessage({
    this.message,
    this.id
  });
  Map<String, dynamic> toJson(String userId) =>
      {
        "message": this.message.toString(),
        "user_id": userId,
        "invoice_id":this.id
      };
}

class ClaimDisputeReplyResponse {
  final String text;
  final String code;
  final String type;
  const ClaimDisputeReplyResponse({
    this.code,
    this.text,
    this.type
  });
  factory ClaimDisputeReplyResponse.fromJson(Map<String,dynamic>json) => ClaimDisputeReplyResponse(
      text: json['text'].toString(),
      code: json['code'].toString(),
      type: json['type'].toString()
  );
}
