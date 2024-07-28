import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:wheel_picker/wheel_picker.dart';

class BirthdateInputScreen extends StatefulWidget {
  @override
  _BirthdateInputScreenState createState() => _BirthdateInputScreenState();
}

class _BirthdateInputScreenState extends State<BirthdateInputScreen> {
  final now = DateTime.now();

  late final _yearWheel = WheelPickerController(
    itemCount: 3000,
    initialIndex: now.year,
  );

  late final _hoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex: now.hour % 12,
  );
  late final _minutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: now.minute,
    mounts: [_hoursWheel],
  );

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      size: 200,
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget itemBuilder(BuildContext context, int index) {
      return Text("$index".padLeft(2, '0'), style: textStyle);
    }

    final timeWheels = <Widget>[
      for (final wheelController in [_yearWheel, _hoursWheel, _minutesWheel])
        WheelPicker(
          builder: itemBuilder,
          controller: wheelController,
          looping: wheelController == _minutesWheel,
          style: wheelStyle,
          selectedIndexColor: Colors.redAccent,
        ),
    ];
    timeWheels.insert(1, const Text(":", style: textStyle));

    final amPmWheel = WheelPicker(
      itemCount: 2,
      builder: (context, index) {
        return Text(["AM", "PM"][index], style: textStyle);
      },
      initialIndex: 1,
      looping: false,
      style: wheelStyle.copyWith(
        shiftAnimationStyle: const WheelShiftAnimationStyle(
          duration: Duration(seconds: 1),
          curve: Curves.bounceOut,
        ),
      ),
    );

    return SizedBox(
      width: wheelStyle.size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _centerBar(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...timeWheels,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: amPmWheel,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Don't forget to dispose the controllers at the end.
    _hoursWheel.dispose();
    _minutesWheel.dispose();
    super.dispose();
  }

  Widget _centerBar(BuildContext context) {
    return Center(
      child: Container(
        height: 38.0,
        decoration: BoxDecoration(
          color: const Color(0xFFC3C9FA).withAlpha(26),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
