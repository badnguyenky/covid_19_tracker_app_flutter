import 'package:covid_19_tracker_app_flutter/models/expansionpanel_model.dart';
import 'package:covid_19_tracker_app_flutter/models/symptoms.dart';
import 'package:covid_19_tracker_app_flutter/utils/myclipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constant.dart';

class PreventScreen extends StatefulWidget {
  @override
  _PreventScreenState createState() => _PreventScreenState();
}

class _PreventScreenState extends State<PreventScreen> {
  final List<Symptoms> symptoms = [
    Symptoms("assets/images/headache.png", "Đau đầu"),
    Symptoms("assets/images/nausea.png", "Mệt mỏi"),
    Symptoms("assets/images/cough.png", "Ho"),
    Symptoms("assets/images/fever.png", "Sốt cao"),
    Symptoms("assets/images/shortbreath.png", "Mất vị giác hoặc khứu giác"),
    Symptoms("assets/images/sorethroat.png", "Viêm họng")
  ];

  final List<Symptoms> preventions = [
    Symptoms("assets/images/shot.jpg", "Tiêm vaccine sớm nhất có thể"),
    Symptoms(
        "assets/images/handwashing.png", "Rửa tay thường xuyên với xà phòng"),
    Symptoms("assets/images/facemask.jpg", "Đeo khẩu trang ở nơi công cộng"),
    Symptoms("assets/images/sneezing.png", "Ho hoặc hắt xì vào khăn giấy"),
    Symptoms("assets/images/distance.png", "Giữ khoảng cách ít nhất là 2m"),
    Symptoms("assets/images/home.png", "Cách ly tại nhà nếu có triệu chứng"),
    Symptoms("assets/images/coughinghand.png", "Không đưa tay sờ lên mặt"),
    Symptoms("assets/images/disinfect.png",
        "Thường xuyên lau chùi vật dụng trong nhà"),
  ];

  final List<ExpansionPanelModel> afterVaccines = [
    ExpansionPanelModel(
        header: "Trên cánh tay nơi được tiêm",
        body: "• Đau\n\n• Mẩn đỏ\n\n• Sưng tấy",
        image: "assets/images/pain.png"),
    ExpansionPanelModel(
        header: "Trên các phần còn lại của cơ thể",
        body:
            "• Mệt mỏi\n\n• Đau đầu\n\n• Đau cơ\n\n• Ớn lạnh\n\n• Sốt\n\n• Buồn nôn",
        image: "assets/images/vaccine_fever.png"),
  ];
  final List<ExpansionPanelModel> advices = [
    ExpansionPanelModel(
        header: "Để giảm đau và cảm giác khó chịu ở nơi tiêm",
        body:
            "• Áp khăn sạch, mát và ẩm lên khu vực đó.\n\n• Vận động hoặc tập thể dục cho cánh tay.",
        image: "assets/images/movearm.png"),
    ExpansionPanelModel(
        header: "Để giảm cảm giác khó chịu do sốt",
        body: "• Uống thật nhiều nước.\n\n• Mặc trang phục nhẹ nhàng.",
        image: "assets/images/drink.png"),
    ExpansionPanelModel(
        header: "Khi nào thì cần gọi cho bác sĩ",
        body:
            "• Tình trạng mẩn đỏ hoặc bị đau ở vị trí tiêm trở nên tồi tệ hơn sau 24 giờ\n\n• Nếu các tác dụng phụ khiến quý vị lo ngại và có vẻ không mất đi sau vài ngày",
        image: "assets/images/nurse.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.only(top: 50),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
                image: DecorationImage(
                    image: AssetImage("assets/images/virus.png"))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 50,
                        left: 20,
                        child: SvgPicture.asset(
                          "assets/icons/coronadr.svg",
                          width: 260,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 200,
                        child: Text("Thông tin về \n DỊCH COVID-19",
                            style: kHeadingTextStyle.copyWith(
                                color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
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
                children: [
                  Row(
                    children: [
                      Text(
                        "Triệu chứng",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              itemCount: symptoms.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                    width: 200,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          symptoms[index].imageurl,
                                          width: 150,
                                        ),
                                        Text(
                                          symptoms[index].title,
                                          style: TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                  )),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
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
                children: [
                  Row(
                    children: [
                      Text(
                        "Phòng ngừa",
                        style: kTitleTextstyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            itemCount: preventions.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: AssetImage(
                                            preventions[index].imageurl),
                                        // radius: 80,
                                      ),
                                      Text(
                                        preventions[index].title,
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                )),
                      )
                    ],
                  )
                ],
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Phản ứng sau tiêm",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: afterVaccines.length,
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  child: ExpansionPanelList(
                      animationDuration: Duration(milliseconds: 500),
                      elevation: 0,
                      expansionCallback: (int item, bool isExpanded) {
                        setState(() {
                          afterVaccines[index].isExpanded =
                              !afterVaccines[index].isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      afterVaccines[index].header,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                            isExpanded: afterVaccines[index].isExpanded,
                            body: Row(
                              children: [
                                Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        afterVaccines[index].image,
                                        width: 150,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    afterVaccines[index].body,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                      ]),
                )),
        Text(
          "Lời khuyên để giảm tác dụng phụ",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: advices.length,
            itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  child: ExpansionPanelList(
                      animationDuration: Duration(milliseconds: 500),
                      elevation: 0,
                      expansionCallback: (int item, bool isExpanded) {
                        setState(() {
                          advices[index].isExpanded =
                              !advices[index].isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      advices[index].header,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                            isExpanded: advices[index].isExpanded,
                            body: Row(
                              children: [
                                Container(
                                  width: 200,
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        advices[index].image,
                                        width: 150,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    advices[index].body,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ))
                      ]),
                )),
        SizedBox(
          height: 50,
        )
      ]),
    );
  }
}
