import 'package:covid_19_tracker_app_flutter/models/country_chart_model.dart';
import 'package:covid_19_tracker_app_flutter/models/global_summary.dart';
import 'package:covid_19_tracker_app_flutter/models/list_provinces.dart';
import 'package:covid_19_tracker_app_flutter/models/vaccine.dart';
import 'package:covid_19_tracker_app_flutter/models/vn_summary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/country_summary.dart';
import 'dart:io';

class CovidService {
  // Future<GlobalSummaryModel> getGlobalSummary() async {
  //   final data =
  //       await http.Client().get(Uri.https("disease.sh", "/v3/covid-19/all"));

  //   if (data.statusCode != 200) throw Exception();

  //   GlobalSummaryModel summary =
  //       new GlobalSummaryModel.fromJson(json.decode(data.body));

  //   return summary;
  // }

  Future<CountrySummaryModel> getCountrySummary(String iso2) async {
    final data = await http
        .get(Uri.https("disease.sh", "/v3/covid-19/countries/" + iso2));

    if (data.statusCode != 200) throw Exception();

    CountrySummaryModel summaryList =
        new CountrySummaryModel.fromJson(json.decode(data.body));

    return summaryList;
  }

  Future<GlobalSummary> getGlobalSummary() async {
    final data =
        await http.get(Uri.https("static.pipezero.com", "/covid/data.json"));

    if (data.statusCode != 200) throw Exception();

    GlobalSummary globalSummary =
        new GlobalSummary.fromJson(json.decode(data.body));

    return globalSummary;
  }

  Future<VnSummary> getSummary() async {
    final data = await http
        .get(Uri.https("covid19.ncsc.gov.vn", "/api/v3/covid/national_total"));

    if (data.statusCode != 200) throw Exception();

    VnSummary summaryList = new VnSummary.fromJson(json.decode(data.body));

    return summaryList;
  }

  Future<Vaccine> getSummaryVaccine() async {
    final data = await http.get(
        Uri.https("covid19.ncsc.gov.vn", "/api/v3/vaccine/national_vaccine"));

    if (data.statusCode != 200) throw Exception();

    Vaccine vaccine = new Vaccine.fromJson(json.decode(data.body));

    return vaccine;
  }

  Future<List<ListProvinces>> getListProvinces() async {
    final data = await http.Client()
        .get(Uri.https("static.pipezero.com", "/covid/data.json"));

    if (data.statusCode != 200) throw Exception();

    Map<String, dynamic> datas =
        new Map<String, dynamic>.from(json.decode(data.body));
    List<ListProvinces> provinces = (datas['locations'] as List)
        .map((item) => new ListProvinces.fromJson(item))
        .toList();
    return provinces;
  }

  Future<List<CountryChartModel>> getChartSummary(String iso2) async {
    final data = await http.Client()
        .get(Uri.https("api.covid19api.com", "/total/dayone/country/" + iso2));
    if (data.statusCode != 200) throw Exception();

    List<CountryChartModel> chartList = (json.decode(data.body) as List)
        .map((item) => new CountryChartModel.fromJson(item))
        .toList();

    return chartList;
  }

  Future<List<CountrySummaryModel>> getCountryList() async {
    final data = await http.Client()
        .get(Uri.https("disease.sh", "/v3/covid-19/countries/"));

    if (data.statusCode != 200) throw Exception();

    List<CountrySummaryModel> countries = (json.decode(data.body) as List)
        .map((item) => new CountrySummaryModel.fromJson(item))
        .toList();

    return countries;
  }
}

class IgnoreCertificateErrorOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}
