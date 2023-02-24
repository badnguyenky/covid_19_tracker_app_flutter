import 'package:covid_19_tracker_app_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;

  CountryLoading({@required this.inputTextLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        inputTextLoading ? loadingInput() : Container(),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Thông tin dịch bệnh", style: kTitleTextstyle),
              Text(
                "Xem chi tiết",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        loadingCard(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Cập nhật: __:__ __/__/____',
                    style: TextStyle(color: Colors.black)),
              ])),
              Spacer(),
              Text.rich(
                TextSpan(
                  text: 'Nguồn: ',
                  style: TextStyle(color: kPrimaryColor),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Bộ Y Tế, WHO',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        // ChartLoading()
      ],
    );
  }

  Widget loadingInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color(0xFFE5E5E5))),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          width: double.infinity,
          height: 20,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget loadingCard() {
    return Container(
        height: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
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
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            color: Colors.white,
          ),
        ));
  }
}
