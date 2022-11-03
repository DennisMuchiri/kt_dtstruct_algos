import 'package:flutter/material.dart';
import 'package:loyaltyapp/campaign/view/campaign_screen.dart';
import 'package:loyaltyapp/claim/view/claim_list_page.dart';
import 'package:loyaltyapp/dashboard/view/dashboard_screen.dart';
import 'package:loyaltyapp/message/view/message_list_screen.dart';
import 'package:loyaltyapp/utils/ui/pgbison_app_theme.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  int currentIndex = 0;

  final List<Widget> viewContainer = [
    DashboardScreen(),
    MessageListScreen(),
    ClaimListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      //If you want to show body behind the navbar, it should be true
      extendBody: false,
      body: viewContainer[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: currentIndex,
        fixedColor: Colors.amber[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
            /*title: Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
                color: ((currentIndex==0?Colors.amber[800]:PGBisonAppTheme.pg_grey_2)),//PGBisonAppTheme.pg_grey_2,
              ),
            ),*/
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',/*Text('Messages',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
                    color: ((currentIndex==1?Colors.amber[800]:PGBisonAppTheme.pg_grey_2)),
                  ))*/),
          BottomNavigationBarItem(
            icon: Icon(Icons.attractions),
            label:  'Claims',
            /*Text(
              'Claims',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                fontFamily: PGBisonAppTheme.font_Poppins_SemiBold,
                color: ((currentIndex==2?Colors.amber[800]:PGBisonAppTheme.pg_grey_2)),
              ),
            ),*/
          ),
          //BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
        ],
      ),
    );
  }
}
