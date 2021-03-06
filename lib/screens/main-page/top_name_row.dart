import 'package:corona_virus/icons/custom_icons.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TopNameRow extends StatefulWidget {
  StateModel state;

  TopNameRow(this.state);

  @override
  _TopNameRowState createState() => _TopNameRowState();
}

class _TopNameRowState extends State<TopNameRow> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: new Text(
                  this.widget.state.selectedCountry == null
                      ? "WORLDWIDE"
                      : this.widget.state.selectedCountry.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                ))),
        new IconButton(
            icon: Icon(
              FontAwesome5Solid.globe_europe,
              color: (this.widget.state.selectedCountry == null)
                  ? Colors.white
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: () => this.widget.state.selectedCountry = null),
      ],
    );
  }
}
