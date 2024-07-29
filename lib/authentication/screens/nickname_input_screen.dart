import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speed_dating_front/authentication/screens/birth_input_screen.dart';
import 'package:speed_dating_front/authentication/screens/gender_input_screen.dart';

class NicknameInputScreen extends StatefulWidget {
  final String phoneNumber;
  final Gender gender;

  const NicknameInputScreen({
    super.key,
    required this.phoneNumber,
    required this.gender,
  });

  @override
  _NicknameInputScreenState createState() => _NicknameInputScreenState();
}

class _NicknameInputScreenState extends State<NicknameInputScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String _nickname = '';

  void _submitNickname() {
    setState(() {
      _nickname = _nicknameController.text.trim();
    });

    // 여기에 닉네임 제출에 대한 추가 로직을 추가할 수 있습니다.
    // 예를 들어, 서버로 닉네임을 전송하거나 다음 화면으로 이동하는 등의 작업을 할 수 있습니다.
    if (_nickname.isNotEmpty) {
      // 예시로 스낵바를 표시합니다.
      _focusNode.unfocus();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BirthdateInputScreen(
                  phoneNumber: widget.phoneNumber,
                  nickname: _nickname,
                  gender: widget.gender,
                )),
      );
    }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '닉네임을 입력해주세요.',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'nickname',
                        hintText: 'nickname',
                      ),
                      onSubmitted: (value) => _submitNickname(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 40,
                  left: 16,
                  right: 16,
                ),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitNickname,
                    child: Text('확인'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
