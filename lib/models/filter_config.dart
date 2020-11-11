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

Map<FILTER, IconData> filter2icon = {
  FILTER.CASES: FontAwesome5.address_book,
  FILTER.DEATHS: MyCustomIcons.deaths,
  FILTER.RECOVERED: FontAwesome5.heart,
};
