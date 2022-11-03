import 'package:loyaltyapp/claim/view/claim_list_page.dart';
import 'package:loyaltyapp/dashboard/view/dashboard_screen.dart';
import 'package:loyaltyapp/message/view/message_list_screen.dart';
import 'package:loyaltyapp/home/home_page_xx.dart';
import 'destination.dart';
import 'package:flutter/material.dart';

class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination,this.onNavigation }) : super(key: key);

  final Destination destination;
  final VoidCallback onNavigation;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );

  }

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title} Text'),
        backgroundColor: widget.destination.color,
      ),
      backgroundColor: widget.destination.color[100],
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(controller: _textController),
      ),
    );
  }*/
/*  @override
  Widget build(BuildContext context) {
    print("DEST ${widget.destination.title}");
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        print("NOT GETTING HERE");
        print("SET ${settings.name}");
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return DashboardScreen(destination: widget.destination);
              case '/list':
                return MessageListScreen(destination: widget.destination);
              case '/text':
                return ClaimListScreen(destination: widget.destination);
            }
            return HomePage();
          },
        );
      },
    );
  }*/
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return DashboardScreen(destination: widget.destination);
              case '/list':
                return MessageListScreen(destination: widget.destination);
              case '/text':
                return ClaimListScreen(destination: widget.destination);
            }
          },
        );
      },
    );
  }
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver(this.onNavigation);

  final VoidCallback onNavigation;

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
}
