import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loyaltyapp/claim/bloc/claim_cubit.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loyaltyapp/redemption/bloc/redemption_cubit.dart';
import 'package:loyaltyapp/redemption/redemption_model.dart';
import 'package:loyaltyapp/redemption/redemption_repository.dart';
import 'package:loyaltyapp/redemption/view/redemption_list_screen.dart';

class RedeemPointsPage extends StatefulWidget {
  //final String amountRedeemed;
  const RedeemPointsPage();//this.amountRedeemed
  @override
  _RedeemPointsPageState createState() => _RedeemPointsPageState();
}

class _RedeemPointsPageState extends State<RedeemPointsPage> {
  final _searchController = TextEditingController();
  final _amountController = TextEditingController();
  final _redemptionTypeController = TextEditingController();
  final _commentController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool enableButton;
  String runningBalance = '0';

  @override
  void initState() {
    enableButton = false;
    super.initState();
    _callRunningBalAPI();
    //runningBalance = _amountController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem Points"),
      ),
      body: BlocProvider(
        create: (context) => ClaimCubit(ClaimRepository()),
        child: Container(
          child: BlocConsumer<ClaimCubit, ClaimState>(
            listener: (context, state) {
              if (state is ClaimSearchSubmitted) {
                print(state.claimSearchResponse.length);
                if (state.claimSearchResponse.length == 1) {
                  Claim claim = state.claimSearchResponse[0];

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(claim.text ?? ""),
                  ));
                }
                if (state is ClaimSearchSubmitting) {
                  enableButton = false;
                }
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Running Balance $runningBalance",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "Poppins"),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "Poppins"),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              readOnly: true,
                              controller: _amountController,//TextEditingController(text: widget.amountRedeemed),//_amountController,
                              decoration: InputDecoration(
                                  labelText: "Amount to Redeem",
                                  helperText: "Amount to redeem less than $runningBalance",
                                  labelStyle: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: HexColor("#1F2430")),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  labelText: 'Redeem as',
                                  labelStyle: GoogleFonts.poppins(
                                      textStyle:
                                          TextStyle(color: HexColor("#1F2430")),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal),
                                ),
                                items: [
                                  DropdownMenuItem(child: Text("--Select Redemption Type--"), value: ""),
                                  DropdownMenuItem(child: Text("Cash"), value: "Cash"),
                                  DropdownMenuItem(child: Text("Product"), value: "Product"),
                                ],

                                onChanged: (value) {
                                  setState(() {
                                    _redemptionTypeController.text = value;
                                  });

                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: _commentController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  labelText: "Comments",
                                  labelStyle: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: HexColor("#1F2430")),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )),
                          ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _redeem(context);
                              },
                              child: Text("Redeem"),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _callRunningBalAPI() async {
    var repository = RedemptionRepository();
    Future<RedemptionBalance> balance = repository.getBalance();//.then((value) => print(value.running_balance));
    balance.then((value) {
      _amountController.text = value.runningBalance;
      setState(() {
        runningBalance = value.runningBalance ?? "0";
      });
    });

  }

  _redeem(BuildContext context) {
    enableButton = false;
    final redemptionRepository = RedemptionRepository();
    final cubit = RedemptionCubit(redemptionRepository);
    var response = cubit.redeemPoint(
        RedeemPoint(
            amount:  _amountController.text,//widget.amountRedeemed,//
            comments: _commentController.text,
            redemptionType: _redemptionTypeController.value.text
        )).then((value) => {
      Fluttertoast.showToast(
          msg: value.text,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0)
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: onError.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }).whenComplete(() => {
      _commentController.clear(),
      _amountController.clear(),
      _redemptionTypeController.clear(),
      //Navigator.pop(context)
      Navigator.push(context,    MaterialPageRoute(builder: (context) => RedemptionListScreen()))
    });


  }
}
