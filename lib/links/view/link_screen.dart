import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loyaltyapp/links/bloc/link_bloc.dart';
import 'package:flutter_html/style.dart';
import 'package:loyaltyapp/links/link_model.dart';
import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/widgets/drawer.dart';
import 'package:loyaltyapp/widgets/loading.dart';
import 'package:loyaltyapp/widgets/error_retry.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_html/flutter_html.dart';

import 'link_detail.dart';

class LinkScreen extends StatefulWidget {
  static const String routeName = '/link';
  @override
  _LinkState createState() => _LinkState();
}

class _LinkState extends State<LinkScreen> {
  LinkBloc _bloc;
  final String title = "Links";

  @override
  void initState() {
    super.initState();
    _bloc = new LinkBloc();
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white54,
              child: RefreshIndicator(

                onRefresh: () => _bloc.fetchCampaignList(),
                child: StreamBuilder<ApiResponse<List<Link>>>(
                  stream: _bloc.campaignListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;
                        case Status.COMPLETED:
                          return LinkList(linkList: snapshot.data.data);
                          break;
                        case Status.ERROR:
                          return Error(
                              errorMessage: snapshot.data.message,
                              onRetryPressed: () => _bloc.fetchCampaignList());
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


class LinkList extends StatelessWidget {
  final List<Link> linkList;
  LinkList({Key key, this.linkList}) : super(key: key);
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight =
        size.height * 0.09; //(size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: Text("Select the link/resource you'd like to view", style: TextStyle(fontSize:18.0,),),
              alignment: Alignment.center,
            )
          ],
        ),
        Row(
          children: [
            Container(
                //color: Colors.grey[100],
                width: MediaQuery.of(context).size.width * 0.99,
                height: MediaQuery.of(context).size.height * 0.80,
                child: GestureDetector(
                    child: GridView.count(
                      crossAxisCount: 2,
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(linkList == null ? 0 : linkList.length, (index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                              child: ChoiceChip(
                                label: Text( linkList[index].linkName ?? ""),
                                selected: _isSelected,
                                onSelected: (bool _isSelected){
                                  if (!_isSelected) {
                                    _isSelected = true;
                                  }
                                  showAlertDialog(context, linkList[index].linkUrl);
                                },
                                pressElevation: 20,
                                selectedColor: Colors.green,
                              )/*ActionChip(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                side: BorderSide(color: Colors.grey)
                              ),

                                label: Text(
                                  linkList[index].linkName ?? "",
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,

                                ),
                                labelStyle: TextStyle(color: Colors.black),
                                onPressed: () {
                                print(_isSelected);
                                if (!_isSelected) {
                                  _isSelected = true;
                                }
                                  showAlertDialog(context, linkList[index].linkUrl);

                                },
                                backgroundColor: _isSelected ? Colors.green : Colors.white38,
                              )*/
                          ),
                        );
                      }),
                    )
                )
            )
          ],
        )
      ],
    );
    //return ;
  }

  showAlertDialog(BuildContext context, String link) {
    // set up the buttons
    Widget cancelButton = Container(
      margin: EdgeInsets.all(1.0),
        child: TextButton(
      /*style: TextButton.styleFrom(
          backgroundColor: Color(0xff00966b),
          textStyle: TextStyle(color: Colors.white)),*/
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text("Cancel", style: TextStyle(color: Colors.brown)),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ));
    Widget continueButton = TextButton( //Color(0xff00966b)
      style: TextButton.styleFrom(
          backgroundColor: Color(0xff00966b),
          textStyle: TextStyle(color: Colors.white)),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "Open Link",
          style: TextStyle(color: Colors.white),
        ),
      ) ,
      onPressed: () {
        Navigator.of(context).pop();
        _launchURL(link);
      },
    ); // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Opening the link"),
      content: RichText(
        text: TextSpan(children: [
          TextSpan(style: TextStyle(color: Colors.blue), text: link),
          TextSpan(
            text: " would mean that you close the PG-Bison app. \n\n",
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
              text: "\n Are you sure you want to open the link?",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600))
        ]),
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:  cancelButton,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: continueButton,
            )


          ],
        )

      ],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //void _launchURL(String url) async => await canLaunch(url) ? _launchURL(url) : throw 'Could not open $url';
  _launchURL(String url) async {
    if (!url.contains('http')) url = 'https://$url';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
