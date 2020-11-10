import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:numeral/numeral.dart';

class TopNumbersRow extends StatelessWidget {
  StateModel state;

  TopNumbersRow(this.state);

  @override
  Widget build(BuildContext context) {
    Column buildTopNumber(Color text_color, int number) {
      return new Column(
        children: <Widget>[
          new Text(
            Numeral(number).value(),
            style: TextStyle(
                fontSize: 36.0, fontWeight: FontWeight.bold, color: text_color),
          )
        ],
      );
    }

    var totalConfirmed = this
        .state
        .coronaData
        .where((country) =>
            this.state.selectedCountry == null || is_country_selected(country))
        .map((e) => e.confirmed)
        .reduce((value, element) => value + element);

    var totalDeaths = this
        .state
        .coronaData
        .where((country) =>
            this.state.selectedCountry == null || is_country_selected(country))
        .map((e) => e.deaths)
        .reduce((value, element) => value + element);

    var totalRecovered = this
        .state
        .coronaData
        .where((country) =>
            this.state.selectedCountry == null || is_country_selected(country))
        .map((e) => e.recovered)
        .reduce((value, element) => element != null ? value + element : value);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildTopNumber(CASES_COLOR, totalConfirmed),
        buildTopNumber(DEATHS_COLOR, totalDeaths),
        buildTopNumber(RECOVERED_COLOR, totalRecovered),
      ],
    );
  }

  bool is_country_selected(CoronaData corona_data) =>
      corona_data.name == this.state.selectedCountry;
}
