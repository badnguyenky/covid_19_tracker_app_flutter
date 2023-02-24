import 'package:covid_19_tracker_app_flutter/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'provinces_detail_page.dart';
import 'world_detail_page.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _currentIndex = 0;
  final List<Widget> pages = <Widget>[ProvincesDetail(), WorldDetail()];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Thông tin chi tiết"),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.flag), label: "Việt Nam"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.globe), label: "Thế giới")
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
