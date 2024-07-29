import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/controller/auth_controller.dart';
import 'package:speed_dating_front/authentication/screens/pin_number_input_screen.dart';
import 'package:http/http.dart' as http;

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({super.key});

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  final _phoneController = TextEditingController();
  final _controller = AuthController();
  bool _isButtonEnabled = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_isValidPhoneNumber);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _isValidPhoneNumber() {
    final phoneNumber = _phoneController.text;
    setState(() {
      _isButtonEnabled = _controller.isValidPhoneNumber(phoneNumber);
    });
  }

  void _onSendCodePressed() {
    _focusNode.unfocus();
    _controller.sendPhoneNumber(_phoneController.text).then(
          (isSuccess) => {
            if (isSuccess)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinCodeInputScreen(
                      phoneNumber: _phoneController.text,
                    ),
                  ),
                )
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('인증번호 전송에 실패했습니다. 다시 시도해주세요.'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                  ),
                )
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('전화번호를 입력해주세요'),
                    SizedBox(height: 20),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: const Text('phone'),
                        hintText: '010-0000-0000',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFC2185B), // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFFCE4EC), // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      autofocus: true,
                      focusNode: _focusNode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _onSendCodePressed : null,
                  child: Text('인증번호 받기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
