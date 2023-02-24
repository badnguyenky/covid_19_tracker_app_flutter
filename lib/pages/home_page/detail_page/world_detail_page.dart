import 'package:covid_19_tracker_app_flutter/models/country_summary.dart';
import 'package:covid_19_tracker_app_flutter/models/global_summary.dart';
import 'package:covid_19_tracker_app_flutter/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/constant.dart';

CovidService covidService = CovidService();

class WorldDetail extends StatefulWidget {
  @override
  _WorldDetailState createState() => _WorldDetailState();
}

class _WorldDetailState extends State<WorldDetail> {
  Future<List<CountrySummaryModel>> futureCountryList;

  @override
  void initState() {
    super.initState();
    futureCountryList = covidService.getCountryList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder(
          future: futureCountryList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("Error"),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());

              default:
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : CountriesStatistics(
                        countryListModel: snapshot.data,
                      );
            }
          }),
    );
  }
}

class CountriesStatistics extends StatefulWidget {
  final List<CountrySummaryModel> countryListModel;

  CountriesStatistics({@required this.countryListModel});
  @override
  _CountriesStatisticsState createState() => _CountriesStatisticsState();
}

class _CountriesStatisticsState extends State<CountriesStatistics> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern();
  Future<GlobalSummary> globalSummary;
  @override
  void initState() {
    super.initState();
    globalSummary = covidService.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
            future: globalSummary,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text("Error"),
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());

                default:
                  return !snapshot.hasData
                      ? Center(child: CircularProgressIndicator())
                      : WorldStatistics(globalSummary: snapshot.data);
              }
            }),
        SizedBox(
          height: 20,
        ),
        Text("Các quốc gia", style: kTitleTextstyle),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.countryListModel.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.all(20),
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
                child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 0,
                    expansionCallback: (int item, bool isExpanded) {
                      setState(() {
                        widget.countryListModel[index].isExpanded =
                            !widget.countryListModel[index].isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Row(
                            children: [
                              Text(
                                "${index + 1}",
                                style: kTitleTextstyle,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 10,
                                      color: kShadowColor,
                                    )
                                  ],
                                ),
                                child: Image.network(
                                  widget
                                      .countryListModel[index].countryInfo.flag,
                                  width: 50,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  widget.countryListModel[index].country,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                        isExpanded: widget.countryListModel[index].isExpanded,
                        body: buildBody(context, index),
                      )
                    ]),
              );
            })
      ],
    );
  }

  Padding buildBody(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 160) / 2,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: Counter(
                  color: kInfectedColor,
                  title: "Nhiễm bệnh",
                  number:
                      numberFormat.format(widget.countryListModel[index].cases),
                  today: numberFormat
                      .format(widget.countryListModel[index].todayCases),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 160) / 2,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: Counter(
                    color: kRecovercolor,
                    title: "Hồi phục",
                    number: numberFormat
                        .format(widget.countryListModel[index].recovered),
                    today: numberFormat
                        .format(widget.countryListModel[index].todayRecovered)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 160) / 2,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: Counter(
                  color: kPrimaryColor,
                  title: "Đang điều trị",
                  number: numberFormat
                      .format(widget.countryListModel[index].active),
                  today: "0",
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 160) / 2,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: Counter(
                    color: kDeathColor,
                    title: "Tử vong",
                    number: numberFormat
                        .format(widget.countryListModel[index].deaths),
                    today: numberFormat
                        .format(widget.countryListModel[index].todayDeaths)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class WorldStatistics extends StatelessWidget {
  final GlobalSummary globalSummary;
  final NumberFormat numberFormat = NumberFormat.decimalPattern();
  WorldStatistics({@required this.globalSummary});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text("Thế giới", style: kTitleTextstyle),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                padding: EdgeInsets.all(20),
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
                child: Counter(
                  color: kInfectedColor,
                  title: "Ca nhiễm",
                  number: numberFormat.format(globalSummary.total.world.cases),
                  today: numberFormat.format(globalSummary.today.world.cases),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                padding: EdgeInsets.all(20),
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
                child: Counter(
                    color: kRecovercolor,
                    title: "Hồi phục",
                    number: numberFormat
                        .format(globalSummary.total.world.recovered),
                    today: numberFormat
                        .format(globalSummary.today.world.recovered)),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                padding: EdgeInsets.all(20),
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
                child: Counter(
                  color: kPrimaryColor,
                  title: "Đang điều trị",
                  number:
                      numberFormat.format(globalSummary.total.world.treating),
                  today:
                      numberFormat.format(globalSummary.today.world.treating),
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 80) / 2,
                padding: EdgeInsets.all(20),
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
                child: Counter(
                    color: kDeathColor,
                    title: "Tử vong",
                    number:
                        numberFormat.format(globalSummary.total.world.death),
                    today:
                        numberFormat.format(globalSummary.today.world.death)),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;
  final String today;

  const Counter({Key key, this.color, this.number, this.title, this.today})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color.withOpacity(.26)),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 10,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "$number",
          maxLines: 1,
          style: TextStyle(fontSize: 18, color: color),
        ),
        Text(title, style: kSubTextStyle),
        SizedBox(
          height: 10,
        ),
        Text(
          "+ $today",
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}

class Country {
  String country;
  String slug;
  String iso2;

  Country({this.country, this.slug, this.iso2});
}
