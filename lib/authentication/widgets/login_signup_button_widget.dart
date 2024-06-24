import 'package:flutter/material.dart';

class LoginSignUpButtonWidget extends StatelessWidget {
  const LoginSignUpButtonWidget({
    super.key,
    required this.buttonText,
    required this.routePage,
    required this.backgroundColor,
    required this.textColor,
  });
  final String buttonText;
  final Widget routePage;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => routePage));
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
          ),
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
