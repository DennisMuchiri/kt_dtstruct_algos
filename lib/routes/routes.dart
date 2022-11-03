
import 'package:loyaltyapp/campaign/view/campaign_screen.dart';
import 'package:loyaltyapp/claim/view/claim_list_page.dart';
import 'package:loyaltyapp/contacts/view/contact_screen_fl.dart';
import 'package:loyaltyapp/dashboard/view/dashboard_screen.dart';
import 'package:loyaltyapp/events/view/loyalty_event_list_screen.dart';
import 'package:loyaltyapp/message/view/message.dart';
import 'package:loyaltyapp/registration/view/register_screen.dart';
import 'package:loyaltyapp/redemption/view/redemption_list_screen.dart';
import 'package:loyaltyapp/notices/view/notice_screen.dart';
import 'package:loyaltyapp/contacts/view/contact_screen.dart';
import 'package:loyaltyapp/links/view/link_screen.dart';

class Routes {
  static const String messages = MessageScreen.routeName;
  static const String registration = RegisterScreen.routeName;
  static const String campaigns = CampaignScreen.routeName;
  static const String event = LoyaltyEventListScreen.routeName;
  static const String dashboard = DashboardScreen.routeName;
  static const String claims = ClaimListScreen.routeName;
  static const String redemption = RedemptionListScreen.routeName;
  static const String notice = NoticeListScreen.routeName;
  static const String contact = ContactScreenFL.routeName;//ContactScreen.routeName;
  static const String link = LinkScreen.routeName;
}
