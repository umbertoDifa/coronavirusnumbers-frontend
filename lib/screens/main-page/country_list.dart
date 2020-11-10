import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/services/shared_preferences.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'filter_row.dart';

class CountryList extends StatelessWidget {
  StateModel state;

  CountryList(this.state);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new ListView.builder(
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
              child: _build_bottom_list_listtile(
                  this.state.filteredCoronaData[i], context),
              selectedColor: Colors.white,
              textColor: Theme.of(context).textTheme.headline4.color,
            ));
      },
    ));
  }

  String _getVisibleNumber(CoronaData data) {
    if (this.state.selectedFilter == FILTERS.RECOVERED) {
      return data.recovered.toString();
    } else if (this.state.selectedFilter == FILTERS.DEATHS) {
      return data.deaths.toString();
    }
    return data.confirmed.toString();
  }

  IconButton _buildFavoriteIcon(String country_name, BuildContext context) {
    return IconButton(
        icon: Icon(
          this.state.favoriteCountries.contains(country_name)
              ? Icons.star
              : Icons.star_border,
          color: Theme.of(context).iconTheme.color,
          size: Theme.of(context).iconTheme.size,
        ),
        onPressed: () {
          this.state.toggleFavoriteCountry(country_name);
        });
    //   onPressed: () => update_countries(
    //       country_name, _favoriteCountries, saveFavoriteCountries),
    // );
  }

  // void update_countries(String country_name, Set<String> current_country_set,
  //     Function saving_function) {
  //   if (current_country_set.contains(country_name)) {
  //     current_country_set.remove(country_name);
  //   } else {
  //     current_country_set.add(country_name);
  //   }
  //   saving_function(current_country_set);
  //   setState(() {});
  // }

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
              _getVisibleNumber(corona_data),
              style: TextStyle(
                  color: filter2color[this.state.selectedFilter],
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            )
          ]);
    }

    return ListTile(
      enabled: true,
      selected: is_country_selected(country),
      onTap: () => this.state.selectedCountry = country.name,
      leading: _buildFavoriteIcon(country.name, context),
      title: _build_list_tile_row(country),
    );
  }

  bool is_country_selected(CoronaData corona_data) =>
      corona_data.name == this.state.selectedCountry;
}
