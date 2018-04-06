import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:auth_app/globals.dart' as globals;


class ResolvedPage extends StatefulWidget {
  @override
  _ResolvedPageState createState() => new _ResolvedPageState();
}

class _ResolvedPageState extends State<ResolvedPage> {
  static String routeName = 'resolved-page';

  List data = globals.resolvedList;
  bool isFetching = false;
  int dataLength = globals.resolvedList.length;

  Future<String> deleteSearch(jsonObj) async {
    print("DELETE\n");
    print(jsonObj);

    globals.resolvedList.remove(jsonObj);

    print("RESOLVED LIST");
    print(globals.resolvedList);

    // this.postData(index);
  }

  @override
  Widget build(BuildContext context) {

    print("RESOLVED");
    print(globals.resolvedList);

    final fetchingIndicator = new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          new Padding(
            padding: new EdgeInsets.only(left: 20.0, right: 20.0, bottom: 80.0, top: 0.0),
            child: new CircularProgressIndicator(),
          ),
          new Text(
            "Fetching data...",
            style: new TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );

    final noData = new Center(
      child: new Text(
        "No Resolved Items to show",
        style: new TextStyle(fontSize: 18.0),
      ),
    );

    final itemList = new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Dismissible(
            key: new Key(data[index]['description']),
            onDismissed: (direction) {
              this.deleteSearch(data[index]);
            },
            background: new Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              color: Colors.green,
              child: new Text(
                  'Acknowledged',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24.0)
              ),
            ),
            child: new Column(
              children: <Widget> [
                new ListTile(
                  leading: new Icon(Icons.check, color: Colors.green),
                  title: new Text(data[index]['description']),
                  subtitle: new Text(data[index]['site_id']),
                  //                  trailing: new Icon(Icons.watch_later),
                  onTap: () {tileTapped(data[index]);},
                  onLongPress: () {print('LongPressed'); print(index);},
                ),
                new Divider(
                    height: 10.0
                ),
              ],
            ),
          );
        }
    );

    return new Scaffold(
      body: dataLength==0 ? noData : itemList,
    );
  }

}
