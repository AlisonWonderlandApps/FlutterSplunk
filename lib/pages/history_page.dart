import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  static String routeName = 'history-page';

  @override
  Widget build(BuildContext context) {
    final alucard = new Hero(
        tag: 'hero',
        child: new Padding(
            padding: new EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0, bottom: 16.0),
            child: new CircleAvatar(
              radius: 72.0,
              backgroundColor: Colors.transparent,
              backgroundImage: new AssetImage(
                  'assets/images/avatar.jpg'
              ),
            )
        )
    );

    final welcome = new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(
        'Welcome Alucard!',
        style: new TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(
        'Blah blah this is some text',
        style: new TextStyle(fontSize: 18.0, color: Colors.white),
      ),
    );

    return new Container(
      width: double.infinity,
      padding: new EdgeInsets.all(28.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [
          Colors.pink,
          Colors.pinkAccent,
        ]),
      ),
      child: new Column(
        children: <Widget>[alucard, welcome, lorem],
      ),
    );

  }
}
