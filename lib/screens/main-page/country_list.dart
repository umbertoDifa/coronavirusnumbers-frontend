import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

import 'filter_row.dart';

class CountryList extends StatelessWidget {
  StateModel state;

  CountryList(this.state);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: this.state.filteredCoronaData.length,
      itemBuilder: (context, i) {
        return new Container(
            decoration: new BoxDecoration(
              color: this.state.filteredCoronaData[i].name ==
                      this.state.selectedCountry
                  ? highlight_purple
                  : Theme.of(context).primaryColor,
            ),
            child: ListTileTheme(
              child: buildListTile(this.state.filteredCoronaData[i], context),
              selectedColor: Colors.white,
              textColor: Theme.of(context).textTheme.headline4.color,
            ));
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Theme.of(context).textTheme.headline4.color,
          thickness: 0.5,
        );
      },
    ));
  }

  String _getVisibleNumber(CoronaData data, FILTER filter) {
    if (filter == FILTER.RECOVERED) {
      return Numeral(data.recovered).value();
    } else if (filter == FILTER.DEATHS) {
      return Numeral(data.deaths).value();
    }
    return Numeral(data.confirmed).value();
  }

  IconButton _buildFavoriteIcon(String countryName, BuildContext context) {
    return IconButton(
        icon: Icon(
          this.state.favoriteCountries.contains(countryName)
              ? Icons.star
              : Icons.star_border,
          color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,
        ),
        onPressed: () => this.state.toggleFavoriteCountry(countryName));
  }

  ListTile buildListTile(CoronaData country, BuildContext context) {
    Row buildListTileRow(CoronaData coronaData) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              coronaData.name.toUpperCase().substring(
                  0, coronaData.name.length > 17 ? 17 : coronaData.name.length),
            ),
            new Text(
              _getVisibleNumber(coronaData, this.state.selectedFilter),
              style: TextStyle(
                  color: filter2color[this.state.selectedFilter],
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            )
          ]);
    }

    return ListTile(
      enabled: true,
      selected: isCountrySelected(country),
      onTap: () => this.state.selectedCountry = country.name,
      leading: _buildFavoriteIcon(country.name, context),
      title: buildListTileRow(country),
    );
  }

  bool isCountrySelected(CoronaData corona_data) =>
      corona_data.name == this.state.selectedCountry;
}
