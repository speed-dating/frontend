import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speed_dating_front/authentication/screens/signin_screen.dart';
import 'package:speed_dating_front/authentication/screens/signup_screen.dart';
import 'package:speed_dating_front/authentication/widgets/login_signup_button_widget.dart';
import 'package:speed_dating_front/authentication/widgets/welcome_scaffold_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeScaffoldWidget(
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "WELCOME BACK!\n",
                        style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nEnter personal details to your employee account",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                      child: LoginSignUpButtonWidget(
                    buttonText: "로그인",
                    routePage: SignInScreen(),
                    backgroundColor: Colors.transparent,
                    textColor: Colors.white,
                  )),
                  Expanded(
                      child: LoginSignUpButtonWidget(
                    buttonText: "회원가입",
                    routePage: SignUpScreen(),
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
