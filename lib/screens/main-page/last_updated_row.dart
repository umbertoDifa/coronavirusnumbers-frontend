import 'dart:math';

import 'package:corona_virus/models/state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedRow extends StatelessWidget {
  StateModel state;

  LastUpdatedRow(this.state);

  @override
  Widget build(BuildContext context) {
    var maxLastUpdate =
        this.state.coronaData.map((e) => e.last_update).reduce(max);
    var date = new DateTime.fromMillisecondsSinceEpoch(maxLastUpdate);
    var dateFormatter = DateFormat.yMd();
    var timeFormatter = DateFormat.Hms();

    var formattedDate = dateFormatter.format(date);
    var formattedTime = timeFormatter.format(date);
    return new Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Text(
              "Last update: " + formattedDate + ' ' + formattedTime,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}
