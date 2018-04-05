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
  var swipeDirection;
  static String routeName = 'notifications-page';

  List data;

  Future<String> getData() async {
    // http.Response
    var response = await http.get(
        Uri.encodeFull("https://api.myjson.com/bins/1dlmxv"),
        headers: {
          //"key": "apikey",
          "Accept": "application.json",
        }
    );

    print(response.body);

    this.setState(() {
      data = JSON.decode(response.body);
    });

    print(data[0]['processor']);
    return("success");
  }

  Future<String> getSplunkData() async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(
        '${globals.username}:${globals.password}@techbootcamp.aiam-dh.com', '/rest-techsyd3/services/search/jobs/export', {'username': globals.username, 'password': globals.username, 'output_mode': 'json', 'search': 'savedsearch categoryerrors'});
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    print("RESPONSE");
    print('*************');
    print(response);

    var responseBody = await response.transform(utf8.decoder).join();

    print("RESPONSE BODY");
    print('*************');
    print(responseBody);

    var thedata = JSON.decode(responseBody);
    print('*************');
    print("THEDATA");
    print(thedata);

    data = thedata['result'];
    print('*************');
    print("DATA");
    print(data);

    //return "Success!";
  }

  void tileTapped(tile){
    print("TILE TAPPED: ");
    print(tile);
  }

  @override
  void initState() {
   // this.getData();
    this.getSplunkData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            print("ITEMBUILDER");
            print(data[index]);
            return new Dismissible(
              key: new Key(data[index]['processor']),
              onDismissed: (direction) {
//                data[index]['processor'].removeAt(index);
                if(direction==DismissDirection.endToStart) {
                  print('dismissed to the left');
                } else {
                  print('dismissed to the right');
                }
              },
              background:
              new Container(
                  padding: const EdgeInsets.all(20.0),
                  color: Colors.amber,
                  child: new Text('Acknowledged', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: new TextStyle(fontWeight: FontWeight.bold,fontSize:24.0))
              ),
              child: new ListTile(
                leading: new Icon(Icons.remove_circle),
                title: new Text(data[index]['description']),
                subtitle: new Text(data[index]['site_id']),
//                  trailing: new Icon(Icons.watch_later),
                onTap: () {tileTapped(data[index]);},
                onLongPress: () {print('LongPressed'); print(index);},
              ),
            );
/*            return new ListTile(
                leading: new Icon(Icons.ac_unit),
                title: new Text(data[index]['processor']),
                subtitle: new Text(data[index]['count']),
                trailing: new Icon(Icons.view_headline),
//                onTap: () {tileTapped(data[index]);}
            );*/
          }
      ),
    );
  }
}