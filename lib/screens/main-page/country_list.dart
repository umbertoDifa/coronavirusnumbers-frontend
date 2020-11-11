import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/services/api.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:numeral/numeral.dart';

import '../../models/filter_config.dart';

class CountryList extends StatefulWidget {
  StateModel state;

  CountryList(this.state);

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Future<void> updateCoronaData() async {
    List<CoronaData> res = await ApiManager.fetchCoronaData();
    this.widget.state.coronaData = res;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
          onRefresh: updateCoronaData,
            child: new ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: this.widget.state.filteredCoronaData.length,
      itemBuilder: (context, i) {
        return new Container(
            decoration: new BoxDecoration(
              color: this.widget.state.filteredCoronaData[i].name ==
                      this.widget.state.selectedCountry
                  ? highlight_purple
                  : Theme.of(context).primaryColor,
            ),
            child: ListTileTheme(
              child: buildListTile(
                  this.widget.state.filteredCoronaData[i], context),
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
    )));
  }

  String _getVisibleNumber(CoronaData data, FILTER filter) {
    if (filter == FILTER.RECOVERED) {
      return Numeral(data.recovered != null ? data.recovered : 0).value();
    } else if (filter == FILTER.DEATHS) {
      return Numeral(data.deaths!= null ? data.deaths : 0).value();
    }
    return Numeral(data.confirmed!= null ? data.confirmed : 0).value();
  }

  IconButton _buildFavoriteIcon(String countryName, BuildContext context) {
    return IconButton(
        icon: Icon(
          this.widget.state.favoriteCountries.contains(countryName)
              ? MaterialCommunityIcons.pin
              : MaterialCommunityIcons.pin_outline,
          color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,
        ),
        onPressed: () => this.widget.state.toggleFavoriteCountry(countryName));
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
              _getVisibleNumber(coronaData, this.widget.state.selectedFilter),
              style: TextStyle(
                  color: filter2color[this.widget.state.selectedFilter],
                  fontSize: Theme.of(context).textTheme.headline4.fontSize,
                  fontWeight: FontWeight.bold),
            )
          ]);
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 18.0),
      dense: true,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      enabled: true,
      selected: isCountrySelected(country),
      onTap: () => this.widget.state.selectedCountry = country.name,
      leading: _buildFavoriteIcon(country.name, context),
      title: buildListTileRow(country),
    );
  }

  bool isCountrySelected(CoronaData corona_data) =>
      corona_data.name == this.widget.state.selectedCountry;
}
