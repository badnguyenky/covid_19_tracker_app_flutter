import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/constant.dart';

class ChartLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return loadingChartCard();
  }

  Widget loadingChartCard() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Text(
          "Biểu đồ tổng số ca nhiễm, ca tử vong do COVID-19",
          style: kTitleTextstyle,
        ),
        Card(
          elevation: 0,
          child: Container(
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
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 190,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text("Cập nhật từ: __/__/____ đến __/__/____")
      ],
    );
  }
}
