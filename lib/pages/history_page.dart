import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:auth_app/globals.dart' as globals;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => new _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static String routeName = 'history-page';

  List data = globals.historyList;
  bool isFetching = false;
  int dataLength = globals.historyList.length;

  Future<String> deleteSearch(jsonObj) async {
    var index = jsonObj['idx'];

    print("DELETE\n");

    globals.resolvedList.add(jsonObj);
    globals.historyList.remove(jsonObj);

    var uri = new Uri.https(
        'admin:monitor!@techbootcamp.aiam-dh.com', '/rest-techsyd3/servicesNS/admin/search/saved/searches/categoryerrors$index/', {'output_mode': 'json'});
    var client = new http.Client();
    var request = new http.Request('DELETE', uri);
    var future = client.send(request).then((response)
    => response.stream.bytesToString().then((value)
    => this.postData(jsonObj, index))).catchError((error) => print(error.toString()));


    // this.postData(index);
  }

  Future<String> postData(jsonObj, index) async {
    print("POST\n");
    print(jsonObj["site_id"]);
    print(jsonObj["description"]);

    var uri = new Uri.https(
        'admin:monitor!@techbootcamp.aiam-dh.com',
        '/rest-techsyd3/servicesNS/admin/search/saved/searches/',
        {'output_mode': 'json'});
    var client = new http.Client();
    var request = new http.Request('POST', uri);
    var body = {
      'name': 'categoryerrors$index',
      'search': '| makeresults | eval idx=$index | eval site_id=${jsonObj["site_id"]} | eval priority=${jsonObj["priority"]} | eval description="${jsonObj["description"]}" | eval count=${jsonObj["count"]} | eval read="true" | eval resolved="true" | fields idx site_id priority description count read resolved'
    };
    request.bodyFields = body;
    var future = client.send(request).then((response) =>
        response.stream.bytesToString().then((value) =>
            this.postPermissions(index))).catchError((error) =>
        print(error.toString()));

  }

  Future<String> postPermissions(index) async {
    print("PERMISSIONS\n");

    var uri = new Uri.https(
        'admin:monitor!@techbootcamp.aiam-dh.com', '/rest-techsyd3/servicesNS/admin/search/saved/searches/categoryerrors$index/acl/', {'output_mode': 'json'});
    var client = new http.Client();
    var request = new http.Request('POST', uri);
    var body = {'app': 'search', 'owner': 'admin', 'sharing': 'app', 'perms.read': '*'};
    request.bodyFields = body;
    var future = client.send(request).then((response)
    => response.stream.bytesToString().then((value)
    => print(value.toString()))).catchError((error) => print(error.toString()));
  }

  @override
  Widget build(BuildContext context) {

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

    final highPriorityErrorIcon = new Icon(
      Icons.error,
      color: Colors.red,
    );

    final midPriorityErrorIcon = new Icon(
      Icons.remove_circle,
      color: Colors.orange,
    );

    final noData = new Center(
      child: new Text(
        "No History Items to show",
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
              color: Colors.purple,
              child: new Text(
                  'Resolved',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24.0)
              ),
            ),
            child: new Column(
              children: <Widget> [
                new ListTile(
                  leading: (data[index]['priority'] == '9' || data[index]['priority'] == '8') ? highPriorityErrorIcon : midPriorityErrorIcon,
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
