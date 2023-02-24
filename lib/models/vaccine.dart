class Vaccine {
  int totalVaccine;
  int totalInjected;
  int totalFirstInjected;
  int totalSecordInjected;
  int nationalPopulation;

  Vaccine(
      {this.totalVaccine,
      this.totalInjected,
      this.totalFirstInjected,
      this.totalSecordInjected,
      this.nationalPopulation});

  Vaccine.fromJson(Map<String, dynamic> json) {
    totalVaccine = json['total_vaccine'];
    totalInjected = json['total_injected'];
    totalFirstInjected = json['total_first_injected'];
    totalSecordInjected = json['total_secord_injected'];
    nationalPopulation = json['national_population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_vaccine'] = this.totalVaccine;
    data['total_injected'] = this.totalInjected;
    data['total_first_injected'] = this.totalFirstInjected;
    data['total_secord_injected'] = this.totalSecordInjected;
    data['national_population'] = this.nationalPopulation;
    return data;
  }
}
