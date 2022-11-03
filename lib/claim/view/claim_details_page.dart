import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:loyaltyapp/claim/bloc/claim_cubit.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';
import 'package:loyaltyapp/claim/view/claim_dispute_screen.dart';

class ClaimDetailsPage extends StatefulWidget {
  final String selectedClaim;
  final String claimStatus;
  const ClaimDetailsPage(this.selectedClaim, this.claimStatus);

  @override
  _ClaimDetailsState createState() => _ClaimDetailsState();
}

class _ClaimDetailsState extends State<ClaimDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Claim Details',
            style: TextStyle(fontSize: 20.0),
          )),
      /*bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        unselectedIconTheme: IconThemeData(
          color: Colors.deepOrangeAccent
        ),
        unselectedItemColor: Colors.deepOrangeAccent,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings_display), label: 'Dispute'),
        ],
      ),*/
      body: BlocProvider(
        create: (context) =>
            ClaimCubit(ClaimRepository())..fetchById(widget.selectedClaim),
        child: Container(
          //margin: EdgeInsets.only(left: 1.0),
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<ClaimCubit, ClaimState>(
            listener: (context, state) {
              if (state is ClaimError) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }

              if (state is ClaimFetchByIdSubmitting) {
                return CircularProgressIndicator();
              }
            },
            builder: (context, state) {
              if (state is ClaimFetchByIdSubmitted) {
                Claim claim = state.claimFetchByIdResponse;
                return SingleChildScrollView(
                  child: Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: html(claim),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ClaimDisputeScreen(widget.selectedClaim)),
            );
          },
          label: Text("Messages"),
        ),
        visible: widget.claimStatus.trim() == "Approved" ? true : false,
      ),
    );
  }

  Widget html(Claim claim) => Html(data: """
    <table>
    <colgroup>
    <col width="50%" class='tbl-claim-left' />
    <col span="2" width="50%" />
    </colgroup>

    <tbody>
    <tr>
    <td  colspan='1' class='tbl-claim-left'>Customer</td><td colspan='2'  class='tbl-claim-right-col'>${claim.customerName}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>Date Decarded</td><td colspan='2'  class='tbl-claim-right-col'>${claim.dateDiscarded}</td>
    </tr>
    <tr>
    <td colspan='1'class='tbl-claim-left'>Registered On</td><td colspan='2'  class='tbl-claim-right-col'>${claim.createdOn}</td>
    </tr>
    <tr>
    <td colspan='1'class='tbl-claim-left'>Code</td><td colspan='2'  class='tbl-claim-right-col'>${claim.code}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>Status</td><td colspan='2'  class='tbl-claim-right-col'>${claim.status}</td>
    </tr>
   
    <tr>
    <td colspan='1' class='tbl-claim-left'>Invoice Num</td><td colspan='2'  class='tbl-claim-right-col'>${claim.invoiceNumber}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>Order</td><td colspan='2'  class='tbl-claim-right-col'>${claim.order}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>Sales Excl VAT</td><td colspan='2'  class='tbl-claim-right-col'>${claim.totalSalesExclVat}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>VAT</td><td colspan='2'  class='tbl-claim-right-col'>${claim.vat}</td>
    </tr>
    <tr>
    <td colspan='1' class='tbl-claim-left'>Sales Inc VAT</td><td colspan='2'  class='tbl-claim-right-col'>${claim.salesInclVat}</td>
    </tr>
    </tbody>
    <tfoot>
    
    </tfoot>
    </table>""", style: {
        // tables will have the below background color
        "table": Style(
          backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
          height: MediaQuery.of(context).size.height * 0.9,
        ),
        // some other granular customizations are also possible
        "tr": Style(
            // border: Border(bottom: BorderSide(color: Colors.grey)),
            margin: EdgeInsets.only(top: 20)),
        "th": Style(
          padding: EdgeInsets.all(6),
          backgroundColor: Colors.grey,
        ),
        "td": Style(
          padding: EdgeInsets.all(6),
          alignment: Alignment.topLeft,
        ),
        // text that renders h1 elements will be red
        "h1": Style(color: Colors.red),
        ".tbl-claim-left": Style(
            backgroundColor: Color(0xff00966b), // Colors.green,//[300],
            fontWeight: FontWeight.w600,
            fontSize: FontSize.large, color: Colors.white70,
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
            top: BorderSide(color: Colors.grey[300]),
            right: BorderSide(color: Colors.grey[300]),
            left: BorderSide(color: Colors.grey[300]),
          ),
        ),

        ".tbl-claim-right-col": Style(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]),
            top: BorderSide(color: Colors.grey[300]),
            right: BorderSide(color: Colors.grey[300]),
            left: BorderSide(color: Colors.grey[300]),
            
          ),
        )
      });
}
