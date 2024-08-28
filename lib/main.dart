import 'dart:ffi';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/authentication/screens/birth_input_screen.dart';
import 'package:speed_dating_front/authentication/screens/phone_number_input_screen.dart';
import 'package:speed_dating_front/chat/service/agora_service.dart';
import 'package:speed_dating_front/home/screens/home_screen.dart';

// Global key to access the scaffold messenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() {
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
        // theme: ChatUIKitTheme(
        // ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const String appKey =
      "611193750#1381387"; // todo : extract to env file
  late ChatClient agoraChatClient;
  ScrollController scrollController = ScrollController();
  String? _messageContent, _chatId;
  final List<String> _logText = [];
  late AgoraService agoraService;

  @override
  void initState() {
    super.initState();
    _initAgoraSDK();
    _addAgoraChatListeners();
    agoraService = Provider.of<AgoraService>(context, listen: false);
    agoraService.signIn("shy", null);
  }

  Future<void> _initAgoraSDK() async {
    ChatOptions options = ChatOptions(
      appKey: appKey,
      autoLogin: false,
    );

    await ChatClient.getInstance.init(options);
    await ChatClient.getInstance.startCallback();
  }

  void _addAgoraChatListeners() {
    ChatClient.getInstance.chatManager.addEventHandler(
      'UNIQUE_HANDLER_ID',
      ChatEventHandler(onMessagesReceived: onMessagesReceived),
    );

    ChatClient.getInstance.chatManager.addMessageEvent(
      'UNIQUE_HANDLER_ID',
      ChatMessageEvent(
        onSuccess: (msgId, msg) {
          _addLogToConsole("send message: $_messageContent");
        },
        onError: (msgId, msg, error) {
          _addLogToConsole(
            "send message failed, code: ${error.code}, desc: ${error.description}",
          );
        },
      ),
    );
  }

  void onMessagesReceived(List<ChatMessage> messages) {
    for (var msg in messages) {
      switch (msg.body.type) {
        case MessageType.TXT:
          {
            ChatTextMessageBody body = msg.body as ChatTextMessageBody;
            _addLogToConsole(
              "receive text message: ${body.content}, from: ${msg.from}",
            );
          }
          break;
        case MessageType.IMAGE:
          {
            _addLogToConsole(
              "receive image message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.VIDEO:
          {
            _addLogToConsole(
              "receive video message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.LOCATION:
          {
            _addLogToConsole(
              "receive location message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.VOICE:
          {
            _addLogToConsole(
              "receive voice message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.FILE:
          {
            _addLogToConsole(
              "receive image message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.CUSTOM:
          {
            _addLogToConsole(
              "receive custom message, from: ${msg.from}",
            );
          }
          break;
        case MessageType.CMD:
          {}
          break;
        case MessageType.COMBINE:
        // TODO: Handle this case.
      }
    }
  }

  void _addLogToConsole(String log) {
    _logText.add(_timeString + ": " + log);
    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Padding(
    //       padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => PhoneNumberInputScreen()),
    //                 );
    //               },
    //               child: Text('처음 왔어요'),
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) => PhoneNumberInputScreen()),
    //               );
    //             },
    //             child: Text('이미 계정이 있어요'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    return HomePage();
  }
}
