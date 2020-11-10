class CoronaData {
  final String name;
  final int last_update;
  final int confirmed;
  final int deaths;
  final int recovered;

  CoronaData(
      {this.name,
      this.last_update,
      this.confirmed,
      this.deaths,
      this.recovered});

  factory CoronaData.fromJson(Map<String, dynamic> json) {
    return CoronaData(
        name: json['name'],
        last_update: json['updatedAt'],
        confirmed: json['confirmed'],
        deaths: json['deaths'],
        recovered: json['recovered']);
  }
}
