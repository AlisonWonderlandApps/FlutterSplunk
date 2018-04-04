import 'package:flutter/material.dart';

import './signin_page.dart';
import './landing_page.dart';
import './settings_page.dart';

//Drawer
class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final settingsItem = new ListTile(
      leading: new Icon(Icons.settings),
      title: new Text('Settings'),
      onTap: () =>  Navigator.popAndPushNamed(context, SettingsPage.routeName),
    );

    final notificationsItem = new ListTile(
      leading: new Icon(Icons.notifications),
      title: new Text('Notifications'),
      onTap: () =>  Navigator.popAndPushNamed(context, 'notifications-page'),
    );

    final historyItem = new ListTile(
      leading: new Icon(Icons.library_books),
      title: new Text('History'),
      //onTap: () =>  Navigator.popAndPushNamed(context, 'login-page'),
    );

    final analyticsItem = new ListTile(
      leading: new Icon(Icons.insert_chart),
      title: new Text('Analytics'),
      //onTap: () =>  Navigator.popAndPushNamed(context, 'login-page'),
    );

    final logoutItem = new ListTile(
      leading: new Icon(Icons.exit_to_app),
      title: new Text('Logout'),
      onTap: () => Navigator.pushNamed(context, SignInPage.routeName),
    );

    final body = new Container(
      width: double.infinity,
      padding: new EdgeInsets.all(28.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: new Column(
        children: <Widget>[
          new Divider(
            height: 16.0,
          ),
          logoutItem,
        ],
      ),
    );

    final drawerList = new Container(
      width: double.infinity,
      child: new Column(
        //padding: new EdgeInsets.all(16.0),
        children: <Widget> [
          notificationsItem,
          historyItem,
          analyticsItem,
          settingsItem,
          new Divider(
            height: 16.0
          ),
          logoutItem,
        ],
      ),
    );

    return new Drawer(
      child: new ListView(
        children:[
          new DrawerHeader(
              child: new Hero(
                tag: 'hero',
                child: new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40.0,
                  child: new Image.asset(
                      'assets/images/Accenture-logo.png',
                      width: 40.0,
                  ),
                ),
              ), //Hero
          ),
          drawerList,
          ],
      ),
    );
  }
}
