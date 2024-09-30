import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/common/provider/token_provider.dart';
import 'package:speed_dating_front/dating/screen/create_dating_page.dart';

import 'package:speed_dating_front/home/controller/dating_controller.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/service/dating_service.dart';
import 'package:speed_dating_front/home/widgets/count_down_timer.dart';
import 'package:speed_dating_front/home/widgets/dating_card.dart';
import 'package:speed_dating_front/util/create_dating_storage.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';

class HomePageContent extends StatefulWidget {
  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    return ChangeNotifierProvider(
      create: (context) =>
          DatingController(service: DatingService(tokenProvider))
            ..fetchDatings(0, 10),
      child: HomePageContentScreen(),
    );
  }
}

class HomePageContentScreen extends StatelessWidget {
  void _openCreateDatingScreen(BuildContext context) async {
    final existingModel = await CreateDatingStorage.loadDatingModel();
    print(existingModel?.title);
    if (existingModel != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("작성중인 글을 불러오시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreatingDatingPageScreen(model: existingModel),
                    ),
                  );
                },
                child: Text("불러오기"),
              ),
              TextButton(
                onPressed: () async {
                  await CreateDatingStorage.clearModel();
                  Navigator.of(context).pop(); // Dialog 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatingDatingPageScreen(),
                    ),
                  );
                },
                child: Text("새로 시작하기"),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatingDatingPageScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final datingController = Provider.of<DatingController>(context);
    return Scaffold(
      appBar: null,
      body: datingController.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildSection(
                    context,
                    title: '내가 참여한 스게팅#######',
                    items: datingController.datings,
                  ),
                  _buildSection(
                    context,
                    title: '앞으로 다가오는 스개팅',
                    items: datingController.datings,
                  ),
                  _buildSection(
                    context,
                    title: '[닉네임]님에게 추천할 스게팅',
                    items: datingController.datings,
                  ),
                ],
              ),
            ),
      floatingActionButton: SpeedDialFabWidget(
        secondaryIconsList: [
          Icons.add,
          Icons.list,
        ],
        secondaryIconsText: [
          "스개팅 만들기",
          "내가 만든 스개팅",
        ],
        secondaryIconsOnPress: [
          () => _openCreateDatingScreen(context),
          () => {},
        ],
        secondaryBackgroundColor: Color(0xfffce4ec),
        secondaryForegroundColor: (Color(0xff141314)),
        primaryBackgroundColor: (Color(0xffffcdd2)),
        primaryForegroundColor: (Color(0xff141112)),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<DatingModel> items}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
          Card(
            margin: EdgeInsets.all(10),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  print(item.toJson());
                  return DatingCard(
                    item: item,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
