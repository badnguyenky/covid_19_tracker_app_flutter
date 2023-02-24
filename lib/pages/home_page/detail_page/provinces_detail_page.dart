import 'package:covid_19_tracker_app_flutter/models/list_provinces.dart';
import 'package:covid_19_tracker_app_flutter/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/constant.dart';

CovidService covidService = CovidService();

class ProvincesDetail extends StatefulWidget {
  @override
  _ProvincesDetailState createState() => _ProvincesDetailState();
}

class _ProvincesDetailState extends State<ProvincesDetail> {
  Future<List<ListProvinces>> listProvinces;

  @override
  void initState() {
    super.initState();
    listProvinces = covidService.getListProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FutureBuilder(
          future: listProvinces,
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
                    : ProvinceStatistics(
                        listProvinces: snapshot.data,
                      );
            }
          }),
    );
  }
}

class ProvinceStatistics extends StatefulWidget {
  final List<ListProvinces> listProvinces;

  ProvinceStatistics({@required this.listProvinces});

  @override
  State<ProvinceStatistics> createState() => _ProvinceStatisticsState();
}

class _ProvinceStatisticsState extends State<ProvinceStatistics> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text("Tình hình dịch cả nước", style: kTitleTextstyle),
        SizedBox(
          height: 20,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.listProvinces.length,
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
                        widget.listProvinces[index].isExpanded =
                            !widget.listProvinces[index].isExpanded;
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
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  widget.listProvinces[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                        isExpanded: widget.listProvinces[index].isExpanded,
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
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: (MediaQuery.of(context).size.width - 160),
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
                  title: "Ca nhiễm",
                  number:
                      numberFormat.format(widget.listProvinces[index].cases)),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: (MediaQuery.of(context).size.width - 160),
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
                  title: "Hôm nay",
                  number: numberFormat
                      .format(widget.listProvinces[index].casesToday)),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 160),
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
                    number:
                        numberFormat.format(widget.listProvinces[index].death)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;

  const Counter({Key key, this.color, this.number, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          width: 10,
        ),
        Text(
          "$number",
          style: TextStyle(fontSize: 18, color: color),
        ),
        SizedBox(
          width: 10,
        ),
        Text(title, style: TextStyle(fontSize: 13)),
      ],
    );
  }
}
