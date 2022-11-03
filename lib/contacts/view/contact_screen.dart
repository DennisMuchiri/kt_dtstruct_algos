import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loyaltyapp/contacts/bloc/contact_bloc.dart';
import 'package:loyaltyapp/contacts/view/contact_detail.dart';
import 'package:loyaltyapp/contacts/contact_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact';
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<ContactScreen> {
  ContactBloc _bloc;
  final String title = "Contacts";

  @override
  void initState() {
    super.initState();
    _bloc = new ContactBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: RefreshIndicator(
                /*onRefresh: () async {
                        return await Future.delayed(Duration(seconds: 3));
                      },*/
                onRefresh: () => _bloc.fetchContactList(),
                child: StreamBuilder<ApiResponse<List<Contact>>>(
                  stream: _bloc.campaignListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;
                        case Status.COMPLETED:
                          return CampaignList(campaignList: snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                              errorMessage: snapshot.data.message,
                              onRetryPressed: () => _bloc.fetchContactList());
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class CampaignList extends StatelessWidget {
  final List<Contact> campaignList;
  const CampaignList({Key key, this.campaignList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (campaignList == null || campaignList.length == 0) {
      return Container(
          child: Column(children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Text(
                "No contacts yet",
                style: TextStyle(
                  color: Color(0xff00966b),
                  fontSize: 24,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
      ]));
    } else {
      return ListView.builder(
        itemCount: campaignList == null ? 0 : campaignList.length,
        //itemCount: campaignList == null ? 1 : campaignList.length+1,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              height: 105,
              margin: EdgeInsets.only(left: 7),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey),
              )),
              child: Card(
                elevation: 0.0,
                color: Colors.grey[100],
                //(index % 2 == 0) ? Colors.grey[200] : Colors.grey[100],
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.only(left: 0, top: 5, right: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.08,
                      /*child: Icon(Icons
                        .contacts)
                    ,*/
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
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  //color: Color(0x33ffcc33),
                                ),
                                child: Text(
                                  campaignList[index].website ?? "",
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff00966b),
                                      decoration: TextDecoration.underline),
                                ), /**/
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5, right: 10),
                                /*child: new Icon(
                                  Icons.dialer_sip,
                                  color: Colors.green,
                                ),*/
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green[200]),
                              ) /**/
                            ],
                          ),
                          Text(
                            campaignList[index].name ?? "",
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w500),
                          ),
                          new Text(
                            campaignList[index].email ?? "",
                            style: new TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new Text(
                            campaignList[index].address +
                                    ", " +
                                    campaignList[index].county ??
                                "",
                            style: new TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Row(
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
                                      campaignList[index].telephone ?? "",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              /*Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactDetail(campaignList[index].id)));*/
            },
          );
        },
      );
    }
  }
}
