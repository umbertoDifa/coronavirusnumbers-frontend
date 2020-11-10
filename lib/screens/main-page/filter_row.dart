import 'package:corona_virus/models/state_model.dart';
import 'package:corona_virus/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:corona_virus/icons/custom_icons.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum FILTER {
  CASES,
  RECOVERED,
  DEATHS,
}

Map<FILTER, String> filter2name = {
  FILTER.CASES: 'CASES',
  FILTER.DEATHS: 'DEATHS',
  FILTER.RECOVERED: 'RECOVERED',
};

Map<FILTER, Color> filter2color = {
  FILTER.CASES: CASES_COLOR,
  FILTER.DEATHS: DEATHS_COLOR,
  FILTER.RECOVERED: RECOVERED_COLOR,
};

class FilterRow extends StatelessWidget {
  StateModel state;

  FilterRow(this.state);

  @override
  Widget build(BuildContext context) {
    InkWell buildFilterIcon(
        BuildContext context, IconData icon, FILTER filterType) {
      return new InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                splashRadius: 10.0,
                icon: Icon(
                  icon,
                  color: (this.state.selectedFilter == filterType)
                      ? filter2color[filterType]
                      : Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    filter2name[filterType],
                    style: TextStyle(
                        color: (this.state.selectedFilter == filterType)
                            ? filter2color[filterType]
                            : Theme.of(context).textTheme.headline6.color,
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize,
                        fontWeight:
                            Theme.of(context).textTheme.headline6.fontWeight),
                  )),
            ],
          ),
          onTap: () => this.state.selectedFilter = filterType);
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildFilterIcon(context, FontAwesome5.address_book, FILTER.CASES),
        buildFilterIcon(context, MyCustomIcons.deaths, FILTER.DEATHS),
        buildFilterIcon(context, FontAwesome5.heart, FILTER.RECOVERED),
      ],
    );
  }
}
