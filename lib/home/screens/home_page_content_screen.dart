import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/common/provider/token_provider.dart';

import 'package:speed_dating_front/home/controller/dating_controller.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/service/dating_service.dart';
import 'package:speed_dating_front/home/widgets/count_down_timer.dart';
import 'package:speed_dating_front/home/widgets/dating_card.dart';

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
  @override
  Widget build(BuildContext context) {
    final datingController = Provider.of<DatingController>(context);
    return datingController.isLoading
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
