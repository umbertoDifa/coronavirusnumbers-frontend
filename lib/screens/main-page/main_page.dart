import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/screens/main-page/country_list.dart';
import 'package:corona_virus/models/filter_config.dart';
import 'package:corona_virus/screens/main-page/last_updated_row.dart';
import 'package:corona_virus/screens/main-page/search.dart';
import 'package:corona_virus/screens/main-page/top_name_row.dart';
import 'package:corona_virus/screens/main-page/top_numbers_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Consumer<StateModel>(
                builder: (context, state, child) => TopNameRow(state)),
            Consumer<StateModel>(
                builder: (context, state, child) => TopNumbersRow(state)),
            SearchBar(),
            Consumer<StateModel>(
                builder: (context, state, child) => CountryList(state)),
            Consumer<StateModel>(
                builder: (context, state, child) => LastUpdatedRow(state)),
          ],
        ),
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
