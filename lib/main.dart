import 'dart:async';

import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/authentication/screens/phone_number_input_screen.dart';
import 'package:speed_dating_front/chat/service/agora_service.dart';

// Global key to access the scaffold messenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      Provider<AgoraService>(
        create: (_) => AgoraService(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.redM3),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      home: ChatUIKit(
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late AgoraService agoraService;

  @override
  void initState() {
    super.initState();

    final agoraService = Provider.of<AgoraService>(context, listen: false);
    agoraService.setOnMessagesReceivedCallback((messages) {
      for (var msg in messages) {
        if (msg.body.type == MessageType.TXT) {
          ChatTextMessageBody body = msg.body as ChatTextMessageBody;
          String content = body.content;
          String sender = "test"; // todo : change

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("New message from $sender: $content"),
              duration: Duration(milliseconds: 500),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () {
                  // 사용자가 알림을 클릭할 때 실행할 작업
                  // todo : navigate to chat page
                },
              ),
            ),
          );
        }
      }
    });
    agoraService.initAgoraSDK();
    agoraService.signIn("shy", null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhoneNumberInputScreen()),
                    );
                  },
                  child: Text('처음 왔어요'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneNumberInputScreen()),
                  );
                },
                child: Text('이미 계정이 있어요'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
