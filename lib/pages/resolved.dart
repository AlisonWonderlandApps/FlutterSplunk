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

  Future<String> deleteSearch(jsonObj) async {
    print("DELETE\n");
    print(jsonObj);

    var index = jsonObj['idx'];

    globals.resolvedList.remove(jsonObj);

    print("RESOLVED LIST");
    print(globals.resolvedList);

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
      'search': '| makeresults | eval site_id=${jsonObj["site_id"]} | eval priority=${jsonObj["priority"]} | eval description="${jsonObj["description"]}" | eval count=${jsonObj["count"]} | eval read="true" | eval resolved="true" | fields site_id priority description count read resolved'
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
      body: isFetching ? fetchingIndicator : itemList,
    );
  }

}