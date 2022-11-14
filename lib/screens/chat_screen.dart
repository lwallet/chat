import 'package:flutter/material.dart';
import 'package:chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class ChatScreen extends StatefulWidget {
  static const id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late InAppWebViewController controller;
  //String url='https://docs.google.com/forms/d/e/1FAIpQLSdw2JpWbdQUuCePiETUnnBuFrAOJ4wVcOt5Fvt1ACOZydU6ng/viewform?usp=sf_link';
  String url ='https://forms.office.com/Pages/ResponsePage.aspx?id=WfMuUNgvSE-ET-88eYuquL9twe7g7t9GplrSTUgkvRhUQjVKM1ROOENBUE0xNzJYOFNPSzJIRDkxRi4u';
  double progress = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text('Questionnary'),
  ),
  body: SafeArea(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(padding: const EdgeInsets.all(10),
          child: progress <1.0 ? LinearProgressIndicator(value: progress):Container()),
          Expanded(child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(url),


              ),
              onWebViewCreated: (webViewController) => controller = webViewController,
              onLoadStart: (controller,url){
                setState(() {
                  this.url=url as String;
                });
              } ,
              onLoadStop: (controller,url){
                setState(() {
                  this.url=url as String;
                });
              },
              onProgressChanged: (controller,progress){
                setState(() {
                  this.progress=progress/100;
                });
              } ,
            ),
          )

          )],
      ),
    ),
  ),); }}




/*class ChatScreen extends StatefulWidget {
  static const id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  void getMessages()async{
    final texting = await _firestore.collection('texting').get();
    for (var message in texting.docs){
      print(message.data());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                getMessages();
               // _auth.signOut();
               // Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('texting').add({'text': messageText, 'sender':loggedInUser.email});
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/