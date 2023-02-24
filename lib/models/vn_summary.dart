class VnSummary {
  int newCase;
  int newDeath;
  int newRecovered;
  int newActive;
  int totalCase;
  int totalDeath;
  int totalActive;
  int totalRecovered;
  int compareActive7DaysBefore;
  int compareCase7DaysBefore;
  int compareDeath7DaysBefore;
  int compareRecovered7DaysBefore;
  int percentRecoveredSumCase;
  String lastUpdated;

  VnSummary(
      {this.newCase,
      this.newDeath,
      this.newRecovered,
      this.newActive,
      this.totalCase,
      this.totalDeath,
      this.totalActive,
      this.totalRecovered,
      this.compareActive7DaysBefore,
      this.compareCase7DaysBefore,
      this.compareDeath7DaysBefore,
      this.compareRecovered7DaysBefore,
      this.percentRecoveredSumCase,
      this.lastUpdated});

  VnSummary.fromJson(Map<String, dynamic> json) {
    newCase = json['new_case'];
    newDeath = json['new_death'];
    newRecovered = json['new_recovered'];
    newActive = json['new_active'];
    totalCase = json['total_case'];
    totalDeath = json['total_death'];
    totalActive = json['total_active'];
    totalRecovered = json['total_recovered'];
    compareActive7DaysBefore = json['compare_active_7_days_before'];
    compareCase7DaysBefore = json['compare_case_7_days_before'];
    compareDeath7DaysBefore = json['compare_death_7_days_before'];
    compareRecovered7DaysBefore = json['compare_recovered_7_days_before'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_case'] = this.newCase;
    data['new_death'] = this.newDeath;
    data['new_recovered'] = this.newRecovered;
    data['new_active'] = this.newActive;
    data['total_case'] = this.totalCase;
    data['total_death'] = this.totalDeath;
    data['total_active'] = this.totalActive;
    data['total_recovered'] = this.totalRecovered;
    data['compare_active_7_days_before'] = this.compareActive7DaysBefore;
    data['compare_case_7_days_before'] = this.compareCase7DaysBefore;
    data['compare_death_7_days_before'] = this.compareDeath7DaysBefore;
    data['compare_recovered_7_days_before'] = this.compareRecovered7DaysBefore;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}
