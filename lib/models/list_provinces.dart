class ListProvinces {
  bool isExpanded;
  String name;
  int death;
  int treating;
  int cases;
  int recovered;
  int casesToday;

  ListProvinces(
      {this.isExpanded,
      this.name,
      this.death,
      this.treating,
      this.cases,
      this.recovered,
      this.casesToday});

  ListProvinces.fromJson(Map<String, dynamic> json) {
    isExpanded = false;
    name = json['name'];
    death = json['death'];
    treating = json['treating'];
    cases = json['cases'];
    recovered = json['recovered'];
    casesToday = json['casesToday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['death'] = this.death;
    data['treating'] = this.treating;
    data['cases'] = this.cases;
    data['recovered'] = this.recovered;
    data['casesToday'] = this.casesToday;
    return data;
  }
}
