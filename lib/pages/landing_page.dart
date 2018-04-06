import 'package:flutter/material.dart';

import 'notifications_page.dart';
import 'history_page.dart';
import 'resolved.dart';
import 'sample_chart.dart';
import 'settings_page.dart';
import 'signin_page.dart';
import 'package:auth_app/globals.dart' as globals;

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class LandingPage extends StatefulWidget {
  //LandingPage({Key key, this.username, this.password}) : super(key: key);
  static String routeName = 'landing-page';

  final drawerItems =  [
    new DrawerItem("Notifications", Icons.notifications),
    new DrawerItem("History", Icons.library_books),
    new DrawerItem("Resolved", Icons.check),
    new DrawerItem("Analytics", Icons.insert_chart),
    new DrawerItem("Settings", Icons.settings),
    new DrawerItem("Logout", Icons.exit_to_app),
  ];

  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch(pos) {
      case 0:
        return new NotificationsPage();
      case 1:
        return new HistoryPage();
      case 2:
        return new ResolvedPage();
      case 3:
        return new AnalyticsPage();
      case 4:
        return new SettingsPage();
      case 5:
        return new SignInPage();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    print(index);
    if(index==5){
      globals.notificationsList = new List();
      globals.historyList = new List();
      globals.resolvedList = new List();
      globals.username = '';
      globals.password = '';
      Navigator.of(context).pushNamed(SignInPage.routeName);
    }
    else {
      setState(() => _selectedDrawerIndex = index);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = [];

    for (var i=0; i< widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      print(d);
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(
            d.title,
            style: new TextStyle(fontStyle: FontStyle.italic),
          ),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(
          widget.drawerItems[_selectedDrawerIndex].title,
          style: new TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(right: 20.0),
            child: new Image.asset(
              'assets/images/RA-logo.png',
              width: 35.0,
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget> [
            new DrawerHeader(
              child: new Hero(
                tag: 'hero',
                child: new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 100.0,
                  child: new Image.asset(
                    'assets/images/RA-logo.png',
                    width: 100.0,
                  ),
                ),
              ), //Hero
            ),
            //new UserAccountsDrawerHeader(accountName: new Text("Alucard"), accountEmail: null),
            new Column(
              children: drawerOptions
            ),
          ],
       ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
