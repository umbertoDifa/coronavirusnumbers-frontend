import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/screens/main-page/main_page.dart';
import 'package:corona_virus/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:corona_virus/services/api.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => StateModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Corona Numbers',
      theme: appTheme(),
      home: Consumer<StateModel>(
          builder: (context, state, child) =>
              MyHomePage(state: state, title: 'Corona Virus Numbers')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.state, this.title}) : super(key: key);

  final String title;
  final StateModel state;

  @override
  _MyHomePageState createState() => _MyHomePageState(state);
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFetching;
  final StateModel globalState;

  _MyHomePageState(this.globalState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _coronaBody(),
    );
  }

  void updateData() async {
    setState(() {
      _isFetching = true;
    });
    var data = await ApiManager.fetchCoronaData();
    setState(() {
      _isFetching = false;
    });
    this.globalState.coronaData = data;
  }

  void loadPreferences() async {
    Set<String> res = await SharedPreferencesManager.getFavoriteCountries();
    this.globalState.favoriteCountries = res;
  }

  @override
  void initState() {
    super.initState();
    updateData();
    loadPreferences();
  }

  Widget _coronaBody() {
    if (_isFetching) {
      return Center(child: CircularProgressIndicator());
    }
    return MainPage();
  }
}
