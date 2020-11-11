import 'package:corona_virus/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/filter_config.dart';

class FilterIcon extends StatelessWidget {
  const FilterIcon({
    Key key,
    @required this.state,
    @required this.icon,
    @required this.filterType,
  }) : super(key: key);

  final StateModel state;
  final IconData icon;
  final FILTER filterType;

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(0.0),
                child: Text(
                  filter2name[filterType],
                  style: TextStyle(
                      color: (this.state.selectedFilter == filterType)
                          ? filter2color[filterType]
                          : Theme.of(context).textTheme.headline6.color,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                      fontWeight:
                          Theme.of(context).textTheme.headline6.fontWeight),
                )),
          ],
        ),
        onTap: () => this.state.selectedFilter = filterType);
  }
}
