import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyaltyapp/campaign/view/campaign_screen.dart';
import 'package:loyaltyapp/claim/view/claim_list_page.dart';
import 'package:loyaltyapp/contacts/view/contact_screen.dart';
import 'package:loyaltyapp/contacts/view/contact_screen_fl.dart';
import 'package:loyaltyapp/dashboard/view/dashboard_screen.dart';
import 'package:loyaltyapp/login/view/login_page.dart';
import 'package:loyaltyapp/user/user_repository.dart';
import 'package:loyaltyapp/home/home_page.dart';
import 'package:loyaltyapp/redemption/view/redemption_list_screen.dart';
import 'package:loyaltyapp/notices/view/notice_screen.dart';
import 'package:loyaltyapp/links/view/link_screen.dart';
import 'package:loyaltyapp/utils/ui/pgbison_app_theme.dart';

import 'authentication/authentication_repository.dart';
import 'authentication/bloc/authentication_bloc.dart';
import 'routes/routes.dart';
import 'splash/splash.dart';
import 'events/view/loyalty_event_list_screen.dart';
import 'message/view/message_list_screen.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      /*theme: Theme.of(context).copyWith(
          accentIconTheme: Theme.of(context).accentIconTheme.copyWith(
              color: Colors.white
          ),
          //accentColor: Color(0xff00966b),
          primaryColor: Color(0xff00966b),
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
              color: Colors.white
          ),
          primaryTextTheme: Theme
              .of(context)
              .primaryTextTheme
              .apply(bodyColor: Colors.white)
      ),*/
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary:
              //Color(0xff00966b)
              PGBisonAppTheme.pg_Green,
        ),
        primaryColor: PGBisonAppTheme.pg_Green, //Colors.green,
        primaryIconTheme:
            Theme.of(context).primaryIconTheme.copyWith(color: Colors.white),
      ),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                /*_navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );*/
                _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      routes: {
        Routes.campaigns: (context) => CampaignScreen(),
        Routes.dashboard: (context) => DashboardScreen(),
        Routes.event: (context) => LoyaltyEventListScreen(),
        Routes.messages: (context) => MessageListScreen(),
        Routes.claims: (context) => ClaimListScreen(),
        Routes.redemption: (context) => RedemptionListScreen(),
        Routes.contact: (context) => ContactScreen(), //ContactScreenFL()
        Routes.link: (context) => LinkScreen(),
        Routes.notice: (context) => NoticeListScreen()
      },
    );
  }
}
