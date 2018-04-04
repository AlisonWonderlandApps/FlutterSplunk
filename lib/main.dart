import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/signin_page.dart';
import './pages/home_page.dart';
import './pages/landing_page.dart';
import './pages/notifications_page.dart';
import './pages/analytics_page.dart';
import './pages/history_page.dart';
import './pages/settings_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    SignInPage.routeName: (context) => new SignInPage(),
    HomePage.routeName: (context) => new HomePage(),
    LandingPage.routeName: (context) => new LandingPage(),
    //NotificationsPage.routeName: (context) => new NotificationsPage(),
    //AnalyticsPage.routeName: (context) => new AnalyticsPage(),
    //HistoryPage.routeName: (context) => new HistoryPage(),
    //SettingsPage.routeName: (context) => new SettingsPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Auth Pages',
      theme: new ThemeData(
        //primarySwatch: Colors.lightBlue,
      ),
      home: new SignInPage(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new LoginPage(),
    );
  }
}
