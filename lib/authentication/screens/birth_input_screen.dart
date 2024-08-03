import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/controller/auth_controller.dart';
import 'package:speed_dating_front/authentication/model/user.dart';
import 'package:speed_dating_front/authentication/screens/gender_input_screen.dart';
import 'package:speed_dating_front/home/screens/home_screen.dart';
import 'package:spinner_date_picker/date_picker/date_picker.dart';

class BirthdateInputScreen extends StatefulWidget {
  final String phoneNumber;
  final String nickname;
  final Gender gender;

  const BirthdateInputScreen(
      {super.key,
      required this.phoneNumber,
      required this.nickname,
      required this.gender});

  @override
  _BirthdateInputScreenState createState() => _BirthdateInputScreenState();
}

class _BirthdateInputScreenState extends State<BirthdateInputScreen> {
  String birthDate = "";
  AuthController _authController = AuthController();

  ValueNotifier<DateTime> dateNotifier = ValueNotifier(
    DateTime(2020, MonthsOfYear.march.number, 12),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xFFC2185B), // 여기서 색상을 변경
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder(
              valueListenable: dateNotifier,
              builder: (context, date, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("생년월일을 입력해주세요."),
                      SizedBox(height: 20),
                      SpinnerDatePicker(
                          initialDate: date,
                          dateOptions: const [
                            DateOptions.d,
                            DateOptions.m,
                            DateOptions.y
                          ],
                          textStyle: TextStyle(color: Colors.red),
                          onDateChanged: (date) {
                            setState(() {
                              dateNotifier.value = date;
                              birthDate =
                                  "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                            });
                          }),
                    ],
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await _authController.sendUserCreation(
                      UserModel(
                          gender: widget.gender,
                          phoneNumber: widget.phoneNumber,
                          nickname: widget.nickname,
                          country: 'KR',
                          birthDate: birthDate));

                  if (result) {
                    print("heree");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage()), // 이동할 화면
                      (Route<dynamic> route) => false, // 모든 기존 화면을 제거
                    );
                  }
                },
                child: Text('완료!'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
