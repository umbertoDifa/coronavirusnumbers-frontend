import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/screens/main-page/filter_row.dart';
import 'package:corona_virus/services/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class StateModel extends ChangeNotifier {
  String _selectedCountry;
  String get selectedCountry => _selectedCountry;
  void set selectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  FILTERS _selectedFilter = FILTERS.CASES;
  FILTERS get selectedFilter => _selectedFilter;
  void set selectedFilter(FILTERS filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  List<CoronaData> _coronaData;
  List<CoronaData> get coronaData => _coronaData;
  void set coronaData(List<CoronaData> data) {
    _coronaData = data;
    notifyListeners();
  }

  Set<String> _favoriteCountries = {};
  Set<String> get favoriteCountries => _favoriteCountries;

  void set favoriteCountries(Set<String> countries) {
    _favoriteCountries = countries;
    notifyListeners();
  }

  void toggleFavoriteCountry(String country) {
    if (_favoriteCountries.contains(country)) {
      _favoriteCountries.remove(country);
    } else {
      _favoriteCountries.add(country);
    }
    SharedPreferencesManager.saveFavoriteCountries(_favoriteCountries);
    notifyListeners();
  }

  List<CoronaData> get filteredCoronaData {
    if (_selectedFilter != null && _coronaData != null) {
      if (_selectedFilter == FILTERS.CASES) {
        _coronaData.sort((a, b) => compare(a, b, (e) => e.confirmed));
      } else if (_selectedFilter == FILTERS.DEATHS) {
        _coronaData.sort((a, b) => compare(a, b, (e) => e.deaths));
      } else {
        _coronaData.sort((a, b) =>
            compare(a, b, (e) => e.recovered == null ? 0 : e.recovered));
      }
      return _coronaData;
    } else {
      print('empty filteredcoronadata');
      return [];
    }
  }

  int compare(CoronaData a, CoronaData b, Function accessor) {
    if (is_country_pair_comparable(a, b)) {
      return accessor(a) > accessor(b) ? -1 : 1;
    }
    if (_favoriteCountries.contains(a.name)) {
      return -1;
    }
    return 1;
  }

  bool is_country_pair_comparable(CoronaData a, CoronaData b) {
    return _favoriteCountries.contains(a.name) &&
            _favoriteCountries.contains(b.name) ||
        !_favoriteCountries.contains(a.name) &&
            !_favoriteCountries.contains(b.name);
  }
}
