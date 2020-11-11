import 'package:corona_virus/models/corona_data.dart';
import 'package:corona_virus/models/filter_config.dart';
import 'package:corona_virus/services/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class StateModel extends ChangeNotifier {
  String _selectedCountry;
  String get selectedCountry => _selectedCountry;
  void set selectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  FILTER _selectedFilter = FILTER.CASES;
  FILTER get selectedFilter => _selectedFilter;
  void set selectedFilter(FILTER filter) {
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

  String _searchString;
  String get searchString => _searchString;
  void set searchString(String s) {
    _searchString = s;
    notifyListeners();
  }

  List<CoronaData> get filteredCoronaData {
    if (_selectedFilter != null && _coronaData != null) {
      orderByFilterType(_coronaData, _selectedFilter);
      return filterBySearchString(_coronaData, _searchString);
    } else {
      return [];
    }
  }

  List<CoronaData> filterBySearchString(List<CoronaData> data, String query) {
    if (data == null || query == null || query.isEmpty) {
      return data;
    }
    return data
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void orderByFilterType(List<CoronaData> data, FILTER filter) {
    if (filter == FILTER.CASES) {
      data.sort((a, b) =>
          compare(a, b, (e) => e.confirmed == null ? 0 : e.confirmed));
    } else if (filter == FILTER.DEATHS) {
      data.sort(
          (a, b) => compare(a, b, (e) => e.deaths == null ? 0 : e.deaths));
    } else {
      data.sort((a, b) =>
          compare(a, b, (e) => e.recovered == null ? 0 : e.recovered));
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
