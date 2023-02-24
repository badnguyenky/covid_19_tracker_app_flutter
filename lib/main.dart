import 'dart:io';

import 'package:covid_19_tracker_app_flutter/constants/constant.dart';
import 'package:covid_19_tracker_app_flutter/pages/chatbot_page.dart';
import 'package:covid_19_tracker_app_flutter/pages/news_page.dart';
import 'package:covid_19_tracker_app_flutter/pages/prevent_page.dart';
import 'package:covid_19_tracker_app_flutter/pages/video_page/videos_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'pages/home_page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          // fontFamily: "Poppins",
          textTheme: TextTheme(
            bodyText2: TextStyle(color: kBodyTextColor),
          )),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;
  bool _isConnected;
  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    PreventScreen(),
    NewsScreen(),
    VideoScreen(),
  ];
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });
      print(err);
    }
  }

  @override
  void initState() {
    _checkInternetConnection();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.bounceInOut,
          color: kPrimaryColor,
          index: 0,
          height: 50,
          items: <Widget>[
            FaIcon(FontAwesomeIcons.virus, size: 20, color: kBackgroundColor),
            FaIcon(FontAwesomeIcons.plus, size: 20, color: kBackgroundColor),
            FaIcon(FontAwesomeIcons.solidNewspaper,
                size: 20, color: kBackgroundColor),
            FaIcon(FontAwesomeIcons.youtube, size: 20, color: kBackgroundColor),
          ],
          onTap: _onItemSelected),
      body: _isConnected == true
          ? widgetOptions.elementAt(_selectedIndex)
          : Center(
              child: Text(
                "Không có kết nối mạng! Vui lòng bật Wifi hoặc mạng dữ liệu và mở lại ứng dụng",
                style: kHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
      floatingActionButton: _isConnected == false
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatbotCovid()));
              },
              child: Icon(Icons.chat),
            ),
    );
  }
}
