import 'package:flutter/material.dart';

import 'notifications_page.dart';
import 'history_page.dart';
import 'analytics_page.dart';
import 'settings_page.dart';
import 'signin_page.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class LandingPage extends StatefulWidget {
  static String routeName = 'landing-page';

  final drawerItems =  [
    new DrawerItem("notifications", Icons.notifications),
    new DrawerItem("history", Icons.library_books),
    new DrawerItem("analytics", Icons.insert_chart),
    new DrawerItem("settings", Icons.settings),
    new DrawerItem("logout", Icons.exit_to_app),
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
        return new AnalyticsPage();
      case 3:
        return new SettingsPage();
      case 4:
        return new SignInPage();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    print(index);
    if(index==4){
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
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget> [
            new UserAccountsDrawerHeader(accountName: new Text("Alucard"), accountEmail: null),
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
