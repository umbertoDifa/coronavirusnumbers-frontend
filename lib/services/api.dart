import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:corona_virus/models/corona_data.dart';

class ApiManager {
  String serverUrl;
  String serverPort;

  ApiManager(this.serverUrl, this.serverPort);

  Future<List<CoronaData>> fetchCoronaData() async {
    final response =
        await http.get(serverUrl + ':' + serverPort + '/api/v1/country');

    var countries;

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      countries = body['countries'];
    } else {
      return [];
    }

    List<CoronaData> corona_data_list = [];

    for (var i = 0; i < countries.length; i++) {
      corona_data_list.add(CoronaData.fromJson(countries[i]));
    }

    return corona_data_list;
  }
}
