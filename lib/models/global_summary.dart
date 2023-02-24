class GlobalSummary {
  Total total;
  Total today;
  List<Overview> overview;
  List<Locations> locations;

  GlobalSummary({this.total, this.today, this.overview, this.locations});

  GlobalSummary.fromJson(Map<String, dynamic> json) {
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    today = json['today'] != null ? new Total.fromJson(json['today']) : null;
    if (json['overview'] != null) {
      overview = <Overview>[];
      json['overview'].forEach((v) {
        overview.add(new Overview.fromJson(v));
      });
    }
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.overview != null) {
      data['overview'] = this.overview.map((v) => v.toJson()).toList();
    }
    if (this.locations != null) {
      data['locations'] = this.locations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Total {
  Internal internal;
  Internal world;

  Total({this.internal, this.world});

  Total.fromJson(Map<String, dynamic> json) {
    internal = json['internal'] != null
        ? new Internal.fromJson(json['internal'])
        : null;
    world = json['world'] != null ? new Internal.fromJson(json['world']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.internal != null) {
      data['internal'] = this.internal.toJson();
    }
    if (this.world != null) {
      data['world'] = this.world.toJson();
    }
    return data;
  }
}

class Internal {
  int death;
  int treating;
  int cases;
  int recovered;

  Internal({this.death, this.treating, this.cases, this.recovered});

  Internal.fromJson(Map<String, dynamic> json) {
    death = json['death'];
    treating = json['treating'];
    cases = json['cases'];
    recovered = json['recovered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['death'] = this.death;
    data['treating'] = this.treating;
    data['cases'] = this.cases;
    data['recovered'] = this.recovered;
    return data;
  }
}

class Overview {
  String date;
  int death;
  int treating;
  int cases;
  int recovered;
  int avgCases7day;
  int avgRecovered7day;
  int avgDeath7day;

  Overview(
      {this.date,
      this.death,
      this.treating,
      this.cases,
      this.recovered,
      this.avgCases7day,
      this.avgRecovered7day,
      this.avgDeath7day});

  Overview.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    death = json['death'];
    treating = json['treating'];
    cases = json['cases'];
    recovered = json['recovered'];
    avgCases7day = json['avgCases7day'];
    avgRecovered7day = json['avgRecovered7day'];
    avgDeath7day = json['avgDeath7day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['death'] = this.death;
    data['treating'] = this.treating;
    data['cases'] = this.cases;
    data['recovered'] = this.recovered;
    data['avgCases7day'] = this.avgCases7day;
    data['avgRecovered7day'] = this.avgRecovered7day;
    data['avgDeath7day'] = this.avgDeath7day;
    return data;
  }
}

class Locations {
  String name;
  int death;
  int treating;
  int cases;
  int recovered;
  int casesToday;

  Locations(
      {this.name,
      this.death,
      this.treating,
      this.cases,
      this.recovered,
      this.casesToday});

  Locations.fromJson(Map<String, dynamic> json) {
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
