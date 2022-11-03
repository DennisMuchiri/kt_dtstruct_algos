import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyaltyapp/links/link_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/links/bloc/link_detail_bloc.dart';

class LinkDetail extends StatefulWidget {
  final String selectedCampaign;
  const LinkDetail(this.selectedCampaign);

  @override
  _LinkDetailState createState() => _LinkDetailState();
}

class _LinkDetailState extends State<LinkDetail> {
  LinkDetailBloc _campaignDetailBloc;

  @override
  void initState() {
    super.initState();
    _campaignDetailBloc = LinkDetailBloc(widget.selectedCampaign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: Text(
              'Link',
              style: TextStyle(fontSize: 20.0),
            )),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 11.0, right: 11.0),
              height: MediaQuery.of(context).size.height * 0.15,
              child: RefreshIndicator(
                onRefresh: () => _campaignDetailBloc
                    .fetchLinkDetail(widget.selectedCampaign),
                child: StreamBuilder<ApiResponse<Link>>(
                  stream: _campaignDetailBloc.campaignDetailStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;

                        case Status.COMPLETED:
                          return ShowCampaignDetail(
                              displayCampaign: snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => _campaignDetailBloc
                                .fetchLinkDetail(widget.selectedCampaign),
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

class ShowCampaignDetail extends StatelessWidget {
  final Link displayCampaign;
  ShowCampaignDetail({Key key, this.displayCampaign}) : super(key: key);

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
                            /*child: Text(
                              displayCampaign.startDate +
                                  " - " +
                                  displayCampaign.endDate,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.green),
                            ),*/
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                               color: Color(0x33ffcc33),
                            ),
                            /*child: new Text(
                              displayCampaign.discountValue+""+displayCampaign.discountType+" OFF",
                              style: new TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                  color: Colors.orangeAccent
                              ),
                            ),*/
                          )

                        ],
                      ),
                      Text(
                        displayCampaign.linkName,
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w500),
                      ),
                      new Text(
                        displayCampaign.linkUrl,
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

