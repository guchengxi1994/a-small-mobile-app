import 'package:flutter/material.dart';
import 'package:freeit/pages/chose_you_want/chose_you_want_view.dart';
import 'package:freeit/pages/extras/report_issues_view.dart';

/// 全局路由
class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class Routers {
  static final main = "main";
  static final classfy = "classfy";
  static final advice = "advice";

  static final Map<String, WidgetBuilder> routers = {
    classfy: (ctx) => ChoseWhatYouPreferredPage(),
    advice: (ctx) => ReportIssuesPage()
  };
}
