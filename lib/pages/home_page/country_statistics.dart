import 'package:covid_19_tracker_app_flutter/models/vn_summary.dart';
import 'package:covid_19_tracker_app_flutter/services/covid_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/constant.dart';
import 'detail_page/detail_page.dart';

CovidService covidService = CovidService();

class CountryStatistics extends StatefulWidget {
  final VnSummary summaryList;

  CountryStatistics({@required this.summaryList});

  @override
  _CountryStatisticsState createState() => _CountryStatisticsState();
}

class _CountryStatisticsState extends State<CountryStatistics> {
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
              Text(" Số liệu COVID-19 tại Việt Nam", style: kTitleTextstyle),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailPage()));
                },
                child: Text(
                  "Xem chi tiết",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Counter(
                      number: numberFormat.format(widget.summaryList.totalCase),
                      color: kInfectedColor,
                      title: 'Số ca nhiễm',
                      today: numberFormat.format(widget.summaryList.newCase),
                    ),
                    Counter(
                      number: numberFormat
                          .format(widget.summaryList.totalRecovered),
                      color: kRecovercolor,
                      title: 'Hồi phục',
                      today:
                          numberFormat.format(widget.summaryList.newRecovered),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Counter(
                      number:
                          numberFormat.format(widget.summaryList.totalActive),
                      color: kPrimaryColor,
                      title: 'Đang điều trị',
                      today: numberFormat.format(widget.summaryList.newActive),
                    ),
                    Counter(
                      number:
                          numberFormat.format(widget.summaryList.totalDeath),
                      color: kDeathColor,
                      title: 'Tử vong',
                      today: numberFormat.format(widget.summaryList.newDeath),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Cập nhật: ${widget.summaryList.lastUpdated}',
                    style: TextStyle(color: Colors.black)),
              ])),
              Spacer(),
              Text.rich(
                TextSpan(
                  text: 'Nguồn: ',
                  style: TextStyle(color: kPrimaryColor),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Bộ Y Tế',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              )
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
  final String today;

  Counter({this.today, this.color, this.number, this.title});

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
