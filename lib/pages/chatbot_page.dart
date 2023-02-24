import 'package:flutter/material.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:covid_19_tracker_app_flutter/constants/constant.dart';

class ChatbotCovid extends StatefulWidget {
  ChatbotCovid({Key key}) : super(key: key);

  @override
  _ChatbotCovidState createState() => _ChatbotCovidState();
}

class _ChatbotCovidState extends State<ChatbotCovid> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  void buildConversation() {
    dynamic conversationObject = {'appId': APP_ID};

    KommunicateFlutterPlugin.buildConversation(conversationObject)
        .then((result) {
      print("Conversation builder success : " + result.toString());
    }).catchError((error) {
      print("Conversation builder error occurred : " + error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    buildConversation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hỏi đáp COVID-19"),
      ),
      body: Chatbot(),
    );
  }
}

class Chatbot extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Color(0xff5c5aa7),
                child: new MaterialButton(
                  onPressed: () {
                    KommunicateFlutterPlugin.openConversations();
                  },
                  minWidth: 400,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  child: Text("Bắt đầu chat",
                      textAlign: TextAlign.center,
                      style: style.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
