import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loyaltyapp/campaign/campaign_model.dart';
import 'package:loyaltyapp/contacts/contact_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:loyaltyapp/campaign/bloc/campaign_detail_bloc.dart';

class CampaignDetail extends StatefulWidget {
  final String selectedCampaign;
  const CampaignDetail(this.selectedCampaign);

  @override
  _CampaignDetailState createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  CampaignDetailBloc _campaignDetailBloc;

  @override
  void initState() {
    super.initState();
    _campaignDetailBloc = CampaignDetailBloc(widget.selectedCampaign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Campaign',
            style: TextStyle(fontSize: 20.0),
          )
      ),
          body: Container(
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300], width: 1 ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: MediaQuery.of(context).size.height * 0.305,
                    child: StreamBuilder<ApiResponse<Campaign>>(
                      stream: _campaignDetailBloc.campaignDetailStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data.status) {
                            case Status.LOADING:
                              return Loading(
                                  loadingMessage: snapshot.data.message);
                              break;

                            case Status.COMPLETED:
                              return ShowCampaignDetail(
                                  displayCampaign: snapshot.data.data);
                              break;
                            case Status.ERROR:
                              return Error(
                                errorMessage: snapshot.data.message,
                                onRetryPressed: () => _campaignDetailBloc
                                    .fetchCampaignDetail(widget.selectedCampaign),
                              );
                              break;
                          }
                        }
                        return Container();
                      },
                    )
                ),
                Container(
                  child: RefreshIndicator(
                      onRefresh: () => _campaignDetailBloc
                          .fetchCampaignDocuments(widget.selectedCampaign),
                      child: StreamBuilder<ApiResponse<List<CampaignDocument>>>(
                        stream: _campaignDetailBloc.campaignDocumentStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.LOADING:
                                return Loading(
                                    loadingMessage: snapshot.data.message);
                                break;

                              case Status.COMPLETED:
                                return CampaignDocumentList(
                                    campaignDocumentList:
                                    snapshot.data.data == null
                                    ? []
                                        : snapshot.data.data);
                                break;
                              case Status.ERROR:
                                return Error(
                                  errorMessage: snapshot.data.message,
                                  onRetryPressed: () =>
                                      _campaignDetailBloc.fetchCampaignDetail(
                                          widget.selectedCampaign),
                                );
                                break;
                            }
                          }
                          return Container();
                        },
                      )
                  ),
                )
              ],
            ),
          )
    );
  }
}

class ShowCampaignDetail extends StatelessWidget {
  final Campaign displayCampaign;
  ShowCampaignDetail({Key key, this.displayCampaign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,

             // child: Expanded(
                child:
                  Card(
                    elevation: 0.0,
                    color: Colors.grey[100],
                    margin: EdgeInsets.all(3),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.980,
                      child: Row(
                        //mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              color: Colors.blue,
                              //child: Icon(Icons.info)

                              child: Icon(Icons.info_outline),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left:10, top: 1),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200]
                                      ),
                                      child: Text(
                                        "Effective from: "+displayCampaign.startDate +
                                            " - " +
                                            displayCampaign.endDate,
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.green),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color(0x33ffcc33),
                                      ),
                                      child: new Text(
                                        displayCampaign.discountValue +
                                            "" +
                                            displayCampaign.discountType +
                                            " OFF",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orangeAccent),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    displayCampaign.campaign,
                                    style: new TextStyle(
                                        fontSize: 12.0, fontWeight: FontWeight.w500),
                                  ),
                                )


                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                )


            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.945,
              height: MediaQuery.of(context).size.height * 0.17850,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                border: Border.all(
                    color: Colors.grey[300]
                ),
                color: Colors.grey[100]
              ),
              child: SingleChildScrollView( padding: EdgeInsets.only(left: 10, top: 5),
                child: new Text(
                  displayCampaign.itemDescription,
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ),

          ],
        ),
      ),

      //),
    );
  }
}

class CampaignDocumentList extends StatelessWidget {
  final List<CampaignDocument> campaignDocumentList;
  const CampaignDocumentList({Key key, this.campaignDocumentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
          itemCount:
          campaignDocumentList == null ? 0 : campaignDocumentList.length,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.56,
              child: Column(
                  children: <Widget>[
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
                  ])

            );
          }),
    ) ;
  }
}