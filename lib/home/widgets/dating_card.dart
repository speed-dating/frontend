import 'package:flutter/material.dart';
import 'package:speed_dating_front/authentication/screens/gender_input_screen.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/widgets/count_down_timer.dart';

class DatingCard extends StatelessWidget {
  final DatingModel item;

  const DatingCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 필요에 따라 너비를 조정할 수 있습니다.
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54.withOpacity(0.6),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        CountDownTimer(startDate: item.startDate),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '# 태그',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      for (var participant in item.participants)
                        if (participant.gender == Gender.FEMALE)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  participant.profileImage ??
                                      "default image url"),
                            ),
                          ),
                      Spacer(),
                      for (var participant in item.participants)
                        if (participant.gender == 'MALE')
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  participant.profileImage ??
                                      "default image url"),
                            ),
                          ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
