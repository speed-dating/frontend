import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:speed_dating_front/authentication/controller/phone_number_controller.dart';
import 'package:speed_dating_front/authentication/controller/pin_code_controller.dart';

class PinCodeInputScreen extends StatefulWidget {
  final String phoneNumber;

  const PinCodeInputScreen({super.key, required this.phoneNumber});

  @override
  _PinCodeInputScreenState createState() => _PinCodeInputScreenState();
}

class _PinCodeInputScreenState extends State<PinCodeInputScreen> {
  final PinCodeController _controller = PinCodeController();
  final PhoneNumberController _phoneNumberController = PhoneNumberController();

  String pinNumber = "";
  final FocusNode _focusNode = FocusNode();
  bool _isButtonEnabled = false;

  void _onCodeChanged(String code) {
    setState(() {
      _isButtonEnabled = (code.length == 4);
    });
  }

  void _onSubmit(String verificationCode) async {
    final isSuccess =
        await _controller.verifyPinCode(widget.phoneNumber, verificationCode);
    print(isSuccess);
    // todo : code 에 따라 다른 분기 타도록 수정
    // success
    // case 1 : 이미 유저가 존재하는 경우 -> 토스트 메시지 + 화면 콜스택 모두 닫기 => 메인페이지 진입
    // case 2 : 유저가 존재하지 않는 경우 -> 회원가입 플로우

    // failure
    // case 1 : 인증코드가 맞지 않는 경우
    // case 2: 요청시간이 지난경우
    // case 3 : internal server error

    if (isSuccess) {
      _showMessageDialog("Success", "정상적으로 수행되었습니다.");
    } else {
      _showMessageDialog("Failure", "코드를 다시 요청해주세요.");
    }
  }

  void _showMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

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
                    onCodeChanged: _onCodeChanged,
                    // onSubmit: (String verificationCode) async {
                    //   print(verificationCode);
                    //   final url = Uri.parse(
                    //       'http://localhost:8080/api/v1/auth/sms-verification/verify');
                    //   final headers = {'Content-Type': 'application/json'};
                    //   final body =
                    //       '{"phoneNumber": "${widget.phoneNumber}", "verifyCode": "${verificationCode}"}';

                    //   print(body);
                    //   try {
                    //     final response =
                    //         await http.post(url, body: body, headers: headers);
                    //     print(response.body);

                    //     if (response.statusCode == HttpStatus.created) {
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return AlertDialog(
                    //               title: Text("success"),
                    //               content: Text('정상적으로 수행되었습니다.'),
                    //             );
                    //           });
                    //     } else {
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return AlertDialog(
                    //               title: Text("failure"),
                    //               content: Text('코드를 다시요청해주세요.'),
                    //             );
                    //           });
                    //     }
                    //   } catch (e) {
                    //     print(e);
                    //   }
                    // }, // end onSubmit
                    onSubmit: (String verificationCode) {
                      _onSubmit(verificationCode);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _phoneNumberController
                        .sendPhoneNumber(widget.phoneNumber),
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
                          _focusNode.unfocus();
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
