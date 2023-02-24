class CountryChartModel {
  final String country;
  final int confirmed;
  final int death;
  final int recovered;
  final int active;
  final DateTime date;

  CountryChartModel(this.country, this.confirmed, this.death, this.recovered,
      this.active, this.date);

  factory CountryChartModel.fromJson(Map<String, dynamic> json) {
    return CountryChartModel(
      json["Country"],
      json["Confirmed"],
      json["Deaths"],
      json["Recovered"],
      json["Active"],
      DateTime.parse(json["Date"]),
    );
  }
}
