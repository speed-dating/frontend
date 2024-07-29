import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:speed_dating_front/authentication/screens/nickname_input_screen.dart';

enum Gender {
  @JsonValue('MALE')
  MALE,

  @JsonValue("FEMALE")
  FEMALE
}

class GenderInputScreen extends StatefulWidget {
  final String phoneNumber;

  const GenderInputScreen({super.key, required this.phoneNumber});

  @override
  _GenderInputScreenState createState() => _GenderInputScreenState();
}

class _GenderInputScreenState extends State<GenderInputScreen> {
  String _selectedGender = ''; // 선택된 성별을 저장

  void _selectGender(Gender gender) {
    setState(() {
      _selectedGender = gender.name;
      _showSnackBar(gender);
    });
  }

  void _showSnackBar(Gender gender) {
    final genderStr = gender == Gender.MALE ? "남성" : "여성";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          height: 150, // 스낵바 높이 설정
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$genderStr을 선택했어요.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '추후 변경이 불가하니 신중히 입력해주세요.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NicknameInputScreen(
                            phoneNumber: widget.phoneNumber,
                            gender: gender,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        '네, 확인했어요',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      // 다시 선택할 수 있도록 처리
                      setState(() {
                        _selectedGender = '';
                      });
                    },
                    child: Text(
                      '아니요, 다시 선택할게요',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // duration: Duration(seconds: 10), // 스낵바 지속 시간
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating, // 스낵바가 떠있는 효과를 줌
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFFC2185B), // 여기서 색상을 변경
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "성별을 입력해주세요.",
                style: TextStyle(fontSize: 18), // 텍스트 스타일을 조정
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _genderButton('남자', _selectedGender == Gender.MALE.name),
                SizedBox(width: 16),
                _genderButton('여자', _selectedGender == Gender.FEMALE.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderButton(String gender, bool isSelected) {
    Gender _gender = gender == "남자" ? Gender.MALE : Gender.FEMALE;

    return Expanded(
      child: ElevatedButton(
        onPressed: () => _selectGender(_gender),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : Colors.white, // 배경색
          side: BorderSide(
              color: isSelected ? Colors.red : Colors.grey, width: 2.0),
          elevation: 0, // 그림자 제거
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
