import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static String routeName = 'settings-page';

  @override
  Widget build(BuildContext context) {
    Widget notificationSection = new Container(
      padding: const EdgeInsets.only(left: 32.0, top: 15.0, bottom: 15.0, right: 32.0 ),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'PUSH NOTIFICATIONS',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.check_box,
            color: Colors.green[500],
          ),
          //new Text('ON'),
        ],
      ),
    );

    Widget accountSection = new Container(
      padding: const EdgeInsets.only(left: 32.0, top: 32.0, bottom: 15.0, right: 32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'ACCOUNT SETTINGS',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.settings,
            color: Colors.grey[500],
          ),
        ],
      ),
    );


    Widget refreshSection = new Container(
      padding: const EdgeInsets.only(left: 32.0, top: 15.0, bottom: 15.0, right: 32.0),
      child: new Row (
        children: <Widget>[
          new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      'SPLUNK UPDATE',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  new Text(
                    'Hourly',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              )
          ),
          new Icon(
            Icons.refresh,
            color: Colors.grey[500],
          ),
        ],
      ),
    );

    Widget displaySection = new Container(
      padding: const EdgeInsets.only(left: 32.0, top: 15.0, bottom: 15.0, right: 32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'DISPLAY',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.text_fields,
            color: Colors.grey[500],
          ),
        ],
      ),
    );

    Widget helpSection = new Container(
      padding: const EdgeInsets.only(left: 32.0, top: 15.0, bottom: 32.0, right: 32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'HELP',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Icon(
            Icons.help_outline,
            color: Colors.grey[500],
          ),
        ],
      ),
    );

    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 150.0,
        child: new Image.asset(
            'assets/images/RA-logo.png'
        ),
      ),
    ); //Hero


    return new Container(
      width: double.infinity,
      child: new Column(
        children: <Widget>[
          accountSection,
          notificationSection,
          refreshSection,
          displaySection,
          helpSection,
          logo
        ],
      ),
    );
  }
}