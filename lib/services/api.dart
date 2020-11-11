import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona_virus/models/corona_data.dart';

class ApiManager {
  static String serverUrl =
      'https://coronavirusnumbers-express-api.herokuapp.com';
  static String serverPort = '443';

  static Future<List<CoronaData>> fetchCoronaData() async {
    final response =
        await http.get(serverUrl + ':' + serverPort + '/api/v1/country');

    var countries;

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      countries = body['countries'];
    } else {
      return [];
    }

    List<CoronaData> coronaDataList = [];

    for (var i = 0; i < countries.length; i++) {
      coronaDataList.add(CoronaData.fromJson(countries[i]));
    }

    return coronaDataList;
  }
}
