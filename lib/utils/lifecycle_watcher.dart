
import 'package:flutter/cupertino.dart';

class LifecycleWatcher extends StatefulWidget {

  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher> with WidgetsBindingObserver{
  AppLifecycleState _lastLifecycleState;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    setState(() {
      _lastLifecycleState = state;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(_lastLifecycleState == null){

    }
  }
  
}