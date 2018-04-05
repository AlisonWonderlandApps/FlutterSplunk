import "dart:convert";
import "dart:async";
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:auth_app/globals.dart' as globals;

class NotificationsPage extends StatefulWidget {
  @override
  createState() => new NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  static String routeName = 'notifications-page';

  var data0;
  var data1;
  var data2;
  var data3;
  var data4;
  var data5;
  var data6;
  var data7;
  var data8;
  var data9;
  var data10;
  var data11;
  var data12;

  List data;

  bool isFetching = true;

  Future<String> deleteSearch(jsonObj) async {
    var index = jsonObj['idx'];
    print("INDEX");
    print(index);

    print("DELETE\n");
    globals.historyList.add(jsonObj);
    globals.notificationsList.remove(jsonObj);

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

    var uri = new Uri.https(
        'admin:monitor!@techbootcamp.aiam-dh.com',
        '/rest-techsyd3/servicesNS/admin/search/saved/searches/',
        {'output_mode': 'json'});
    var client = new http.Client();
    var request = new http.Request('POST', uri);
    var body = {
      'name': 'categoryerrors$index',
      'search': '| makeresults | eval idx=$index | eval site_id=${jsonObj["site_id"]} | eval priority=${jsonObj["priority"]} | eval description="${jsonObj["description"]}" | eval count=${jsonObj["count"]} | eval read="true" | eval resolved="false" | fields idx site_id priority description count read resolved'
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

  Future<String> getSplunkData() async {
    List mydata = new List();
    globals.notificationsList = new List();
    globals.historyList = new List();
    globals.resolvedList = new List();

    var httpClient = new HttpClient();
    var uri = new Uri.https(
     '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors0'});
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var thedata = JSON.decode(responseBody);
    data0 = thedata['result'];
    print(data0);
    mydata.add(data0);
    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors1'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data1 = thedata['result'];
    print(data1);
    mydata.add(data1);


    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors2'});
    print(uri);
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data2 = thedata['result'];
    print(data2);
    mydata.add(data2);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors3'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data3 = thedata['result'];
    print(data3);
    mydata.add(data3);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors4'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data4 = thedata['result'];
    print(data4);
    mydata.add(data4);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors5'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data5 = thedata['result'];
    print(data5);
    mydata.add(data5);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors6'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data6 = thedata['result'];
    print(data6);
    mydata.add(data6);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors7'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data7 = thedata['result'];
    print(data7);
    mydata.add(data7);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors8'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data8 = thedata['result'];
    print(data8);
    mydata.add(data8);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors9'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data9 = thedata['result'];
    print(data9);
    mydata.add(data9);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors10'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data10 = thedata['result'];
    print(data10);
    mydata.add(data10);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors11'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data11 = thedata['result'];
    print(data11);
    mydata.add(data11);

    uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors12'});
    request = await httpClient.getUrl(uri);
    response = await request.close();
    responseBody = await response.transform(utf8.decoder).join();
    thedata = JSON.decode(responseBody);
    data12 = thedata['result'];
    print(data12);
    mydata.add(data12);


    globals.notificationsList = mydata;

    setState(() {
      data = mydata;
      isFetching = false;
    });

    print('*************');
    print('*************');
    print(data);
    return "Success!";
  }

  void tileTapped(tile){
    print("TILE TAPPED: ");
    print(tile);
  }

  @override
  void initState() {
    //this.getData();
    print("INIT STATE");
    List myNotes = globals.notificationsList;
    print(myNotes.length);

    if(myNotes.length < 1){
      this.getSplunkData();
    } else {
      setState((){
        isFetching = false;
        data = globals.notificationsList;
      });
    }

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
      body: isFetching ? fetchingIndicator : itemList,
    );
  }
}