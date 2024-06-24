import 'package:flutter/material.dart';

class WelcomeScaffoldWidget extends StatelessWidget {
  const WelcomeScaffoldWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg1.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: child,
          )
        ],
      ),
    );
  }
}
