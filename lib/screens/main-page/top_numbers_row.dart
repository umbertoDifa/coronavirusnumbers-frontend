import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:corona_virus/utils/math.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:numeral/numeral.dart';

import 'filter_icon.dart';
import '../../models/filter_config.dart';

class TopNumbersRow extends StatefulWidget {
  StateModel state;

  TopNumbersRow(this.state);

  @override
  _TopNumbersRowState createState() => _TopNumbersRowState();
}

class _TopNumbersRowState extends State<TopNumbersRow> {
  @override
  Widget build(BuildContext context) {
    Column buildTopNumber(FILTER filter, int number) {
      return new Column(
        children: <Widget>[
          new Text(
            Numeral(simplifyNumber(number)).value(),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5.fontSize,
                fontWeight: FontWeight.bold,
                color: filter2color[filter]),
          ),
          FilterIcon(
              state: this.widget.state,
              icon: filter2icon[filter],
              filterType: filter),
        ],
      );
    }

    var totalConfirmed = countByField(this.widget.state.coronaData,
        this.widget.state.selectedCountry, (e) => e.confirmed);
    var totalDeaths = countByField(this.widget.state.coronaData,
        this.widget.state.selectedCountry, (e) => e.deaths);
    var totalRecovered = countByField(this.widget.state.coronaData,
        this.widget.state.selectedCountry, (e) => e.recovered);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildTopNumber(FILTER.CASES, totalConfirmed),
        buildTopNumber(FILTER.DEATHS, totalDeaths),
        buildTopNumber(FILTER.RECOVERED, totalRecovered),
      ],
    );
  }

  int countByField(
      List<CoronaData> data, String selectedCountry, Function accessor) {
    return data
        .where(
            (country) => selectedCountry == null || isCountrySelected(country))
        .map(accessor)
        .reduce((value, element) => element != null ? value + element : value);
  }

  bool isCountrySelected(CoronaData corona_data) =>
      corona_data.name == this.widget.state.selectedCountry;
}
