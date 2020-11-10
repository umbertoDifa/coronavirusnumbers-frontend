import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<Set<String>> getFavoriteCountries() async {
    return getSharedPreferences('favorite_countries');
  }

  // getNotificationCountries() async {
  //   _notificationCountries = await getSharedPreferences(
  //       'notification_countries', _notificationCountries);
  // }

  static Future<Set<String>> getSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tmp = prefs.getStringList(key);
    if (tmp != null) {
      return tmp.toSet();
    }
    return new Set<String>();
  }

  static saveFavoriteCountries(Set<String> favorite_countries) async {
    await saveSharedPreferences(
        'favorite_countries', favorite_countries.toList());
  }

  // saveNotificationCountries(Set<String> notification_countries) async {
  //   await saveSharedPreferences(
  //       'notification_countries', notification_countries.toList());
  // }

  static saveSharedPreferences(String key, List<String> strings_to_save) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, strings_to_save);
  }
}
