import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/contacts/bloc/contact_detail_bloc.dart';

import '../contact_model.dart';

class ContactDetail extends StatefulWidget {
  final String selectedCampaign;
  const ContactDetail(this.selectedCampaign);

  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  ContactDetailBloc _campaignDetailBloc;

  @override
  void initState() {
    super.initState();
    _campaignDetailBloc = ContactDetailBloc(widget.selectedCampaign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              'Campaign',
              style: TextStyle(fontSize: 20.0),
            )),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 11.0, right: 11.0),
              height: MediaQuery.of(context).size.height * 0.15,
              child: RefreshIndicator(
                onRefresh: () => _campaignDetailBloc
                    .fetchContactDetail(widget.selectedCampaign),
                child: StreamBuilder<ApiResponse<Contact>>(
                  stream: _campaignDetailBloc.campaignDetailStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;

                        case Status.COMPLETED:
                          return ShowContactDetail(
                              displayCampaign: snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => _campaignDetailBloc
                                .fetchContactDetail(widget.selectedCampaign),
                          );
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ),

          ],
        ));
  }

  @override
  void dispose() {
    _campaignDetailBloc.dispose();
    super.dispose();
  }
}

class ShowContactDetail extends StatelessWidget {
  final Contact displayCampaign;
  ShowContactDetail({Key key, this.displayCampaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100,
          margin: EdgeInsets.only(right: 1),
          child: Card(
            elevation: 0.5,
            color: Colors.white,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 15),
            child: Row(
              children: [
               /* SizedBox(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Icon(Icons
                      .campaign)
                  ,
                ),*/
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                             // color: Color(0x33ffcc33),
                            ),
                            child: Text(
                              displayCampaign.telephone,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                               color: Color(0x33ffcc33),
                            ),
                            child: new Text(
                              displayCampaign.address,
                              style: new TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent
                              ),
                            ),
                          )

                        ],
                      ),
                      Text(
                        displayCampaign.name,
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        displayCampaign.email,
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  //color: Color(0xff00966b),
                                ),
                                child: Text(
                                  campaignList[index].startDate +
                                      " - " +
                                      campaignList[index].endDate,
                                  style: TextStyle(
                                      color: Color(0xff00966b), fontSize: 14),
                                ),
                              )),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        /*child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 11.0, right: 11.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Campaign",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 1),
                      child: Text(displayCampaign.campaign),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text( displayCampaign.startDate +
                          " - " +
                          displayCampaign.endDate,),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.item),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Description",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.itemDescription),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Start Date",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.startDate),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("End Date",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.endDate),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Discount Type",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.discountType ?? ""),
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text("Discount Value",style: TextStyle(fontSize: 15,fontFamily: "Poppins"),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(displayCampaign.discountValue),
                    ),
                  )
                ]),

              ],
            ),
          ),
        ),*/
      ),
    );
  }
}

class CampaignDocumentList extends StatelessWidget {
  final List<CampaignDocument> campaignDocumentList;
  const CampaignDocumentList({Key key, this.campaignDocumentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            campaignDocumentList == null ? 1 : campaignDocumentList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 1),
              child: Column(children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Html(
                        data: campaignDocumentList[index]
                            .uploadedImage), //Text(event.description),
                  )),
                ]),
          ]));
        });
  }
}
