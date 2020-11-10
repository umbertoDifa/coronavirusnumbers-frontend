import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_virus/icons/custom_icons.dart';

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

class FilterRow extends StatelessWidget {
  StateModel state;

  FilterRow(this.state);

  @override
  Widget build(BuildContext context) {
    Column _build_filter_icon(
        BuildContext context, IconData icon, FILTERS filter_type) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              color: (this.state.selectedFilter == filter_type)
                  ? filter2color[filter_type]
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: () => this.state.selectedFilter = filter_type,
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
}
