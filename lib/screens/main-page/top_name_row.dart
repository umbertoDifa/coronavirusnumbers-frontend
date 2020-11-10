import 'package:corona_virus/icons/custom_icons.dart';
import 'package:corona_virus/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopNameRow extends StatelessWidget {
  StateModel state;

  TopNameRow(this.state);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
            child: new Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: new Text(
                  this.state.selectedCountry == null
                      ? "WORLDWIDE"
                      : this.state.selectedCountry.toUpperCase(),
                  style: Theme.of(context).textTheme.headline5,
                ))),
        new IconButton(
            icon: Icon(
              MyCustomIcons.globe,
              color: (this.state.selectedCountry == null)
                  ? Colors.white
                  : Theme.of(context).iconTheme.color,
              size: Theme.of(context).iconTheme.size,
            ),
            onPressed: () => this.state.selectedCountry = null
            // setState(() {});
            ),
      ],
    );
  }
}
