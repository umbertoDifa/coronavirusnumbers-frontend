import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<List<CoronaData>> fetchAlbum() async {
  final response = await http.get('https://services1.arcgis.com/0MSEUqKaxRlEPj5g/arcgis/rest/services/ncov_cases/FeatureServer/2/query?f=json&where=Confirmed%20%3E%200&returnGeometry=false&spatialRel=esriSpatialRelIntersects&outFields=*&orderByFields=Confirmed%20desc&resultOffset=0&resultRecordCount=200&cacheHint=true');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var body = json.decode(response.body);
    List<CoronaData> corona_data_list =[];
    for (var i = 0; i < body['features'].length; i++) {
      corona_data_list.add(CoronaData.fromJson(body['features'][i]));
    }
    return corona_data_list;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CoronaData {
  final String region;
  final int last_update;
//  final Double lat;
//  final Double lng;
  final int confirmed;
  final int deaths;
  final int recovered;

  CoronaData({this.region, this.last_update,
//    this.lat, this.lng,
    this.confirmed, this.deaths, this.recovered});

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
      region: json['attributes']['Country_Region'],
      last_update: json['attributes']['Last_Update'],
//      lat: json['features'][0]['attributes']['Lat'],
//      lng: json['features'][0]['attributes']['Long_'],
      confirmed: json['attributes']['Confirmed'],
      deaths: json['attributes']['Deaths'],
      recovered: json['attributes']['Recovered']
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Corona Virus Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<List<CoronaData>> futureCoronaData;
  Position _currentPosition;
//  _getCurrentLocation();

  @override
  void initState() {
    super.initState();
    futureCoronaData = fetchAlbum();
    _getCurrentLocation();
//    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//  final List<String> entries = <String>['A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C','A', 'B', 'C'];
//
//  Widget _buildSuggestions() {
//    return ListView.builder(
//        padding: const EdgeInsets.all(16.0),
//        itemCount: entries.length,
//        itemBuilder: /*1*/ (context, i) {
//          return ListTile(
//              title: Text(
//              entries[i],
//              style: TextStyle(fontSize: 18.0),
//          )
//        );
//  });
//  }

//  Widget _buildRow(WordPair pair) {
//    return ListTile(
//      title: Text(
//        pair.asPascalCase,
//        style: TextStyle(fontSize: 18.0),
//      ),
//    );
//  }

  Widget _corona_data() {
    return FutureBuilder<List<CoronaData>>(
      future: futureCoronaData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data.length,
              itemBuilder: /*1*/ (context, i) {
                return ListTile(
                    title: Text(
                      snapshot.data[i].region +'  ' + snapshot.data[i].confirmed.toString(),
                      style: TextStyle(fontSize: 18.0),
                    )
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:_corona_data(),//_buildSuggestions(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
