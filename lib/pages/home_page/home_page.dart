import 'package:covid_19_tracker_app_flutter/constants/constant.dart';
import 'package:covid_19_tracker_app_flutter/models/vaccine.dart';
import 'package:covid_19_tracker_app_flutter/models/vn_summary.dart';
import 'package:covid_19_tracker_app_flutter/pages/home_page/chart.dart';
import 'package:covid_19_tracker_app_flutter/models/country_chart_model.dart';
import 'package:covid_19_tracker_app_flutter/models/time_series_cases.dart';
import 'package:covid_19_tracker_app_flutter/pages/home_page/country_loading.dart';
import 'package:covid_19_tracker_app_flutter/pages/home_page/country_statistics.dart';
import 'package:covid_19_tracker_app_flutter/pages/home_page/vaccine_statistics.dart';
import 'package:covid_19_tracker_app_flutter/utils/myClipPath.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../services/covid_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../../models/country_summary.dart';
import 'chart_loading.dart';

CovidService covidService = CovidService();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<CountrySummaryModel>> countryList;
  Future<CountrySummaryModel> countrySummary;
  Future<VnSummary> vnSummary;
  Future<Vaccine> vaccine;
  Future<List<CountryChartModel>> chartList;

  @override
  void initState() {
    super.initState();
    vnSummary = covidService.getSummary();
    chartList = covidService.getChartSummary("VN");
    vaccine = covidService.getSummaryVaccine();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      MyClipPath("Drcorona.svg", 200, "Ở nhà \n là YÊU NƯỚC"),
      Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: vnSummary,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text(
                  "Dữ liệu từ Trung tâm giám sát an toàn không gian mạng đang xảy ra lỗi! Vui lòng thử lại sau.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CountryLoading(inputTextLoading: false);
              default:
                return !snapshot.hasData
                    ? Center(
                        child: Text("Empty"),
                      )
                    : CountryStatistics(summaryList: snapshot.data);
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: vaccine,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("Error"),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CountryLoading(inputTextLoading: false);
              default:
                return !snapshot.hasData
                    ? Center(
                        child: Text("Empty"),
                      )
                    : VaccineStatistics(vaccine: snapshot.data);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FutureBuilder(
            future: chartList,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Error"),
                );

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return ChartLoading();
                case ConnectionState.waiting:
                  return ChartLoading();

                default:
                  return !snapshot.hasData
                      ? Center(
                          child: Text("Empty"),
                        )
                      : snapshot.data.length == 0
                          ? loadingCardChartNoData()
                          : buildCardChart(snapshot.data);
              }
            },
          ),
        ),
      ])
    ]));
  }

  List<charts.Series<TimeSeriesCases, DateTime>> _createData(
      List<CountryChartModel> summaryList) {
    List<TimeSeriesCases> confirmedData = [];
    // List<TimeSeriesCases> activeData = [];
    // List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deathData = [];

    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      // activeData.add(TimeSeriesCases(item.date, item.active));
      // recoveredData.add(TimeSeriesCases(item.date, item.recovered));
      deathData.add(TimeSeriesCases(item.date, item.death));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kInfectedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      // new charts.Series<TimeSeriesCases, DateTime>(
      //   id: 'Active',
      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(kActiveColor),
      //   domainFn: (TimeSeriesCases cases, _) => cases.time,
      //   measureFn: (TimeSeriesCases cases, _) => cases.cases,
      //   data: activeData,
      // ),
      // new charts.Series<TimeSeriesCases, DateTime>(
      //   id: 'Recovered',
      //   colorFn: (_, __) => charts.ColorUtil.fromDartColor(kRecoveredColor),
      //   domainFn: (TimeSeriesCases cases, _) => cases.time,
      //   measureFn: (TimeSeriesCases cases, _) => cases.cases,
      //   data: recoveredData,
      // ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
    ];
  }

  Widget buildCardChart(List<CountryChartModel> chartList) {
    String fromDate = DateFormat('dd/MM/yyyy').format(chartList[0].date);
    String toDate =
        DateFormat('dd/MM/yyyy').format(chartList[chartList.length - 1].date);
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Biểu đồ tổng số ca nhiễm, ca tử vong do COVID-19",
            style: kTitleTextstyle,
          ),
        ),
        Card(
          elevation: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 30,
                  color: kShadowColor,
                )
              ],
            ),
            height: 190,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Chart(
              _createData(chartList),
              animate: true,
            ),
          ),
        ),
        Text("Cập nhật từ: $fromDate đến $toDate")
      ],
    );
  }

  Widget loadingCardChartNoData() {
    return Column(
      children: [
        Card(
          elevation: 0,
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: kShadowColor,
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width - 36,
              height: 190,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.frown,
                    size: 50,
                    color: kPrimaryColor,
                  ),
                  Text(
                    "Không có dữ liệu",
                    style: kTitleTextstyle,
                  ),
                ],
              )),
        ),
        Text(
          "Cập nhật từ: __/__/____ đến __/__/____",
        )
      ],
    );
  }
}
