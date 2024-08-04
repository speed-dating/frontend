import 'dart:ffi';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/screens/birth_input_screen.dart';
import 'package:speed_dating_front/authentication/screens/phone_number_input_screen.dart';
import 'package:speed_dating_front/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexThemeData.light(scheme: FlexScheme.redM3),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.redM3),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
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
