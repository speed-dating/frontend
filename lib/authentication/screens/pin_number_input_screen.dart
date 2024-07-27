import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;

class PinCodeInputScreen extends StatefulWidget {
  final String phoneNumber;

  const PinCodeInputScreen({super.key, required this.phoneNumber});

  @override
  _PinCodeInputScreenState createState() => _PinCodeInputScreenState();
}

class _PinCodeInputScreenState extends State<PinCodeInputScreen> {
  String pinNumber = "";

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Color(0xFFC2185B), // 여기서 색상을 변경
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.phoneNumber}로 보내드린'),
                  Text('4자리 핀코드를 입력해주세요'),
                  SizedBox(height: 20),
                  OtpTextField(
                    autoFocus: true,
                    numberOfFields: 4,
                    mainAxisAlignment: MainAxisAlignment.start,
                    borderColor: Color(0xFFC2185B),
                    cursorColor: Color(0xFFC2185B),
                    fillColor: Color(0xFFC2185B),
                    focusedBorderColor: Color(0xFFC2185B),
                    enabledBorderColor: Color(0xFFFCE4EC),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                      pinNumber += code;
                      if (pinNumber.length >= 4) {
                        setState(() {
                          _isButtonEnabled = true;
                        });
                      }
                    },
                    onSubmit: (String verificationCode) async {
                      print(verificationCode);
                      final url = Uri.parse(
                          'http://localhost:8080/api/v1/auth/sms-verification/verify');
                      final headers = {'Content-Type': 'application/json'};
                      final body =
                          '{"phoneNumber": "${widget.phoneNumber}", "verifyCode": "${verificationCode}"}';

                      print(body);
                      try {
                        final response =
                            await http.post(url, body: body, headers: headers);
                        print(response.body);

                        if (response.statusCode == HttpStatus.created) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("success"),
                                  content: Text('정상적으로 수행되었습니다.'),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("failure"),
                                  content: Text('코드를 다시요청해주세요.'),
                                );
                              });
                        }
                      } catch (e) {
                        print(e);
                      }
                    }, // end onSubmit
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("인증번호 다시 요청하기"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFCE4EC), // 배경색 설정
                      foregroundColor: Colors.black54,
                      // onPrimary: Colors.white, // 텍스트 색상 설정
                      shadowColor: Colors.black38, // 그림자 색상 설정
                      elevation: 5, // 그림자 높이 설정
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          // 핀코드 확인 버튼 클릭 시 행동 추가
                        }
                      : null,
                  child: Text('확인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
