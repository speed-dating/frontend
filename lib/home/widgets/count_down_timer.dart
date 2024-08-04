import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final String startDate;

  const CountDownTimer({super.key, required this.startDate});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late DateTime _eventDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _eventDate = DateTime.parse(widget.startDate);
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _calculateDdays() {
    final currentDate = DateTime.now();
    final difference = _eventDate.difference(currentDate);

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    if (difference.isNegative) {
      return '종료';
    } else if (days == 0 && hours == 0 && minutes == 0 && seconds == 0) {
      return 'D-Day';
    } else {
      return '${days}일 ${hours}시간 ${minutes}분 ${seconds}초';
    }
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _calculateDdays(),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
