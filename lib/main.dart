import 'dart:convert';
import 'dart:math';

import 'package:corona_virus/icons/custom_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoronaData {
  final String name;
  final int last_update;
  final int confirmed;
  final int deaths;
  final int recovered;

  CoronaData(
      {this.name,
      this.last_update,
      this.confirmed,
      this.deaths,
      this.recovered});

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
        name: json['name'],
        last_update: json['updatedAt'],
        confirmed: json['confirmed'],
        deaths: json['deaths'],
        recovered: json['recovered']);
  }
}

var DEATHS_COLOR = Color(0xfff40f4c);
var RECOVERED_COLOR = Color(0xff55aa50);
var CASES_COLOR = Color(0xffefae1d);
const int _purplePrimaryValue = 0xff2a1c66;
const BACKGROUND_COLOR = Color(_purplePrimaryValue);

const MaterialColor primaryPurple = MaterialColor(
  _purplePrimaryValue,
  <int, Color>{
    50: BACKGROUND_COLOR,
    100: BACKGROUND_COLOR,
    200: BACKGROUND_COLOR,
    300: BACKGROUND_COLOR,
    400: BACKGROUND_COLOR,
    500: BACKGROUND_COLOR,
    600: BACKGROUND_COLOR,
    700: BACKGROUND_COLOR,
    800: BACKGROUND_COLOR,
    900: BACKGROUND_COLOR,
  },
);
var highlight_purple = Colors.deepPurple[700];

enum FILTERS {
  CASES,
  RECOVERED,
  DEATHS,
}

Map<FILTERS, String> filter2name = {
  FILTERS.CASES: 'CASES',
  FILTERS.DEATHS: 'DEATHS',
  FILTERS.RECOVERED: 'RECOVERED',
};

Map<FILTERS, Color> filter2color = {
  FILTERS.CASES: CASES_COLOR,
  FILTERS.DEATHS: DEATHS_COLOR,
  FILTERS.RECOVERED: RECOVERED_COLOR,
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Corona Numbers',
      theme: ThemeData(
        primarySwatch: primaryPurple,
        backgroundColor: primaryPurple,
        primaryColor: primaryPurple,
        accentColor: Colors.grey,
        fontFamily: "Century Gothic",
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 28.0,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(fontSize: 13.0, color: Colors.grey),
          headline4: TextStyle(fontSize: 17.0, color: Colors.grey),
          bodyText2: TextStyle(fontSize: 36.0, color: Colors.grey),
        ),
      ),
      home: MyHomePage(title: 'Corona Virus Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<CoronaData>> futureCoronaData;
  List<CoronaData> _filtered_corona_data;
  bool is_fetching;
  FILTERS _filter = FILTERS.CASES;
  String _selected_country = null;
  Set<String> _favorite_countries = {};
  Set<String> _notification_countries = {};

  final SERVER_IP = '34.247.255.80';
  final SERVER_PORT = '8080';

  fetchCoronaData() async {
    setState(() {
      is_fetching = true;
    });

    final response = await http
        .get('http://' + SERVER_IP + ':' + SERVER_PORT + '/api/v1/country');
    print(response);
    print(response.statusCode);
    print(response.body);
    print(response);
    print(response.toString());

    var countries;

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      countries = body['countries'];
    } else {
      setState(() {
        is_fetching = false;
        _filtered_corona_data = [];
      });
      throw Exception('Failed to load corona data');
    }

    List<CoronaData> corona_data_list = [];

    for (var i = 0; i < countries.length; i++) {
      corona_data_list.add(CoronaData.fromJson(countries[i]));
    }

    setState(() {
      is_fetching = false;
      _filtered_corona_data = corona_data_list;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCoronaData();
    get_favorite_countries_from_shared_preferences();
    get_notification_countries_from_shared_preferences();
  }

  Widget _corona_body() {
    if (is_fetching) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          _build_top_name_row(context),
          _build_top_numbers_row(_filtered_corona_data),
          _build_filter_icons_row(context),
          _build_bottom_list(context, _filtered_corona_data),
          _build_last_update_row(_filtered_corona_data),
        ],
      ),
    );
  }

  Padding _build_last_update_row(List<CoronaData> data) {
    var max_last_update = data.map((e) => e.last_update).reduce(max);
    var date = new DateTime.fromMillisecondsSinceEpoch(max_last_update);
    var dateFormatter = DateFormat.yMd();
    var timeFormatter = DateFormat.Hms();

    var formattedDate = dateFormatter.format(date);
    var formattedTime = timeFormatter.format(date);

    return new Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(
              "Last update: " + formattedDate + ' ' + formattedTime,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }

  _get_visible_number(CoronaData data) {
    if (_filter == FILTERS.RECOVERED) {
      return data.recovered.toString();
    } else if (_filter == FILTERS.DEATHS) {
      return data.deaths.toString();
    }
    return data.confirmed.toString();
  }

  Expanded _build_bottom_list(
      BuildContext context, List<CoronaData> corona_data) {
    return new Expanded(
        child: new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: corona_data.length,
      itemBuilder: (context, i) {
        return new Container(
            decoration: new BoxDecoration(
              color: corona_data[i].name == _selected_country
                  ? highlight_purple
                  : Theme.of(context).primaryColor,
            ),
            child: ListTileTheme(
              child: _build_bottom_list_listtile(corona_data[i], context),
              selectedColor: Colors.white,
              textColor: Theme.of(context).textTheme.headline4.color,
            ));
      },
    ));
  }

  ListTile _build_bottom_list_listtile(
      CoronaData country, BuildContext context) {
    Row _build_list_tile_row(CoronaData corona_data) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              corona_data.name.toUpperCase().substring(0,
                  corona_data.name.length > 17 ? 17 : corona_data.name.length),
            ),
            new Text(
              _get_visible_number(corona_data),
              style: TextStyle(
                  color: filter2color[_filter],
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            )
          ]);
    }

    return ListTile(
      enabled: true,
      selected: is_country_selected(country),
      onTap: () => setState(() {
        _selected_country = country.name;
      }),
      leading: _build_favorite_icon(country.name, context),
      title: _build_list_tile_row(country),
    );
  }

  bool is_country_selected(CoronaData corona_data) =>
      corona_data.name == _selected_country;

  IconButton _build_notification_icon(
      String country_name, BuildContext context) {
    return IconButton(
      icon: Icon(
        _notification_countries.contains(country_name)
            ? Icons.notifications
            : Icons.notifications_none,
        color: Theme.of(context).iconTheme.color,
        size: Theme.of(context).iconTheme.size,
      ),
      onPressed: () => update_countries(
          country_name, _notification_countries, save_notification_countries),
    );
  }

  void update_countries(String country_name, Set<String> current_country_set,
      Function saving_function) {
    if (current_country_set.contains(country_name)) {
      current_country_set.remove(country_name);
    } else {
      current_country_set.add(country_name);
    }
    saving_function(current_country_set);
    setState(() {});
  }

  IconButton _build_favorite_icon(String country_name, BuildContext context) {
    return IconButton(
      icon: Icon(
        _favorite_countries.contains(country_name)
            ? Icons.star
            : Icons.star_border,
        color: Theme.of(context).iconTheme.color,
        size: Theme.of(context).iconTheme.size,
      ),
      onPressed: () => update_countries(
          country_name, _favorite_countries, save_favorite_countries),
    );
  }

  Row _build_filter_icons_row(BuildContext context) {
    Column _build_filter_icon(
        BuildContext context, IconData icon, FILTERS filter_type) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              color: (_filter == filter_type)
                  ? filter2color[filter_type]
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: () {
              setState(() {
                _filter = filter_type;
              });
            },
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                filter2name[filter_type],
                style: Theme.of(context).textTheme.headline6,
              )),
        ],
      );
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _build_filter_icon(context, MyCustomIcons.confirmed, FILTERS.CASES),
        _build_filter_icon(context, MyCustomIcons.deaths, FILTERS.DEATHS),
        _build_filter_icon(context, MyCustomIcons.recovered, FILTERS.RECOVERED),
      ],
    );
  }

  Icon _build_themed_icon(IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
      size: Theme.of(context).iconTheme.size,
    );
  }

  Row _build_top_name_row(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: new Text(
                  _selected_country == null
                      ? "WORLDWIDE"
                      : _selected_country.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                ))),
        new IconButton(
            icon: Icon(
              MyCustomIcons.globe,
              color: (_selected_country == null)
                  ? Colors.white
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: () {
              _selected_country = null;
              setState(() {});
            }),
      ],
    );
  }

  Row _build_top_numbers_row(List<CoronaData> corona_data) {
    Column _build_top_number(Color text_color, int number) {
      return new Column(
        children: <Widget>[
          new Text(
            number.toString(),
            style: TextStyle(
                fontSize: 36.0, fontWeight: FontWeight.bold, color: text_color),
          )
        ],
      );
    }

    var totalConfirmed = corona_data
        .where((country) =>
            _selected_country == null || is_country_selected(country))
        .map((e) => e.confirmed)
        .reduce((value, element) => value + element);

    var totalDeaths = corona_data
        .where((country) =>
            _selected_country == null || is_country_selected(country))
        .map((e) => e.deaths)
        .reduce((value, element) => value + element);

    var totalRecovered = corona_data
        .where((country) =>
            _selected_country == null || is_country_selected(country))
        .map((e) => e.recovered)
        .reduce((value, element) => value + element);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _build_top_number(CASES_COLOR, totalConfirmed),
        _build_top_number(DEATHS_COLOR, totalDeaths),
        _build_top_number(RECOVERED_COLOR, totalRecovered),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    apply_filter();

    return Scaffold(
      body: _corona_body(),
    );
  }

  get_favorite_countries_from_shared_preferences() async {
    _favorite_countries =
        await get_shared_preferences('favorite_countries', _favorite_countries);
  }

  get_notification_countries_from_shared_preferences() async {
    _notification_countries = await get_shared_preferences(
        'notification_countries', _notification_countries);
  }

  get_shared_preferences(String key, Set<String> field_to_fill) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tmp = prefs.getStringList(key);
    if (tmp != null) {
      return tmp.toSet();
    }
    return new Set<String>();
  }

  save_favorite_countries(Set<String> favorite_countries) async {
    await save_shared_preferences(
        'favorite_countries', favorite_countries.toList());
  }

  save_notification_countries(Set<String> notification_countries) async {
    await save_shared_preferences(
        'notification_countries', notification_countries.toList());
  }

  save_shared_preferences(String key, List<String> strings_to_save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, strings_to_save);
  }

  void apply_filter() {
    if (_filter != null && _filtered_corona_data != null) {
      if (_filter == FILTERS.CASES) {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e) => e.confirmed));
      } else if (_filter == FILTERS.DEATHS) {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e) => e.deaths));
      } else {
        _filtered_corona_data.sort((a, b) => compare(a, b, (e) => e.recovered));
      }
    }
  }

  int compare(CoronaData a, CoronaData b, Function accessor) {
    if (is_country_pair_comparable(a, b)) {
      return accessor(a) > accessor(b) ? -1 : 1;
    }
    if (_favorite_countries.contains(a.name)) {
      return -1;
    }
    return 1;
  }

  bool is_country_pair_comparable(CoronaData a, CoronaData b) {
    return _favorite_countries.contains(a.name) &&
            _favorite_countries.contains(b.name) ||
        !_favorite_countries.contains(a.name) &&
            !_favorite_countries.contains(b.name);
  }
}
