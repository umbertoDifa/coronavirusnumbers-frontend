import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:corona_virus/utils/math.dart';
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
            Numeral(simplifyNumber(number)).value(),
            style: TextStyle(
                fontSize: 36.0, fontWeight: FontWeight.bold, color: text_color),
          )
        ],
      );
    }

    var totalConfirmed = countByField(
        this.state.coronaData, this.state.selectedCountry, (e) => e.confirmed);
    var totalDeaths = countByField(
        this.state.coronaData, this.state.selectedCountry, (e) => e.deaths);
    var totalRecovered = countByField(
        this.state.coronaData, this.state.selectedCountry, (e) => e.recovered);

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildTopNumber(CASES_COLOR, totalConfirmed),
        buildTopNumber(DEATHS_COLOR, totalDeaths),
        buildTopNumber(RECOVERED_COLOR, totalRecovered),
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
      corona_data.name == this.state.selectedCountry;
}
