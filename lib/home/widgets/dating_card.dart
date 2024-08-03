import 'package:flutter/material.dart';

Widget DatingCard(BuildContext context,
    {required String title, required int itemCount}) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // 여기에 각 아이템에 대한 위젯을 배치
              return Container(
                width: 150,
                margin: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.grey[300],
                child: Center(
                  child: Text('스케팅 ${index + 1}'),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
