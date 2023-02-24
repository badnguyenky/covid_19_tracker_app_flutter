import 'package:covid_19_tracker_app_flutter/models/vaccine.dart';
import 'package:covid_19_tracker_app_flutter/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/constant.dart';

CovidService covidService = CovidService();

class VaccineStatistics extends StatefulWidget {
  final Vaccine vaccine;

  VaccineStatistics({@required this.vaccine});

  @override
  _VaccineStatisticsState createState() => _VaccineStatisticsState();
}

class _VaccineStatisticsState extends State<VaccineStatistics> {
  final NumberFormat numberFormat = NumberFormat.decimalPattern();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(" Số liệu tiêm chủng tại Việt Nam", style: kTitleTextstyle),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            padding: EdgeInsets.all(10),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Counter(
                      number: numberFormat.format(widget.vaccine.totalInjected),
                      color: kInfectedColor,
                      title: 'Số người đã tiêm',
                    ),
                    Counter(
                      number: numberFormat
                          .format(widget.vaccine.totalFirstInjected),
                      color: kRecovercolor,
                      title: 'Tiêm mũi 1',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Counter(
                      number: numberFormat
                          .format(widget.vaccine.totalSecordInjected),
                      color: kPrimaryColor,
                      title: 'Tiêm mũi 2',
                    ),
                    Counter(
                      number: numberFormat.format(widget.vaccine.totalVaccine),
                      color: kDeathColor,
                      title: 'Số liều Vaccine đã về',
                    ),
                  ],
                )
              ],
            ),
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

  Counter({this.color, this.number, this.title});

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
          style: TextStyle(fontSize: 25, color: color),
        ),
        Text(title, style: kSubTextStyle),
      ],
    );
  }
}
