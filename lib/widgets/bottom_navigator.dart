import 'package:flutter/material.dart';
import 'package:loyaltyapp/routes/routes.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);

    });
    switch (_selectedIndex) {
      case 0:
      //Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, Routes.dashboard);
        //});

        break;
      case 1:
      //Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, Routes.messages);
        //});
        _selectedIndex = 1;
        break;
      case 2:
      //Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, Routes.claims);

        //});
        break;
    /*default:
        Future.delayed(Duration.zero, () {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        });*/
    }
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.av_timer_sharp),
          label: 'Claims',
        ),
      ],
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],

    );
  }
}
