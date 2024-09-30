import 'dart:io';
import 'package:flutter/material.dart';

class DatingSummaryWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final int? maleCapacity;
  final int? femaleCapacity;
  final DateTime? startDate;
  final double? price;
  final File? selectedImage;
  final VoidCallback onCreate;

  const DatingSummaryWidget({
    Key? key,
    this.title,
    this.description,
    this.maleCapacity,
    this.femaleCapacity,
    this.startDate,
    this.price,
    this.selectedImage,
    required this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '스개팅 정보 요약',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('제목: $title'),
              SizedBox(height: 5),
              Text('설명: $description'),
              SizedBox(height: 5),
              Text('남녀 참가자: $maleCapacity 대 $femaleCapacity'),
              SizedBox(height: 5),
              Text('시작 날짜: ${startDate?.toLocal().toString().split(' ')[0]}'),
              SizedBox(height: 5),
              Text('참가 비용: $price 원'),
              SizedBox(height: 5),
              if (selectedImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.file(selectedImage!,
                      height: 100, fit: BoxFit.cover),
                ),
              if (selectedImage == null) Text('선택된 이미지 없음'),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onCreate,
                child: Text('스개팅 생성하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
