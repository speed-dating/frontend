import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:speed_dating_front/home/controller/dating_controller.dart';
import 'package:speed_dating_front/home/models/dating.dart';

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DatingController()..fetchDatings(0, 10),
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
                  title: 'some title1',
                  items: datingController.datings,
                ),
                _buildSection(
                  context,
                  title: 'some title 2',
                  items: datingController.datings,
                ),
                _buildSection(
                  context,
                  title: 'some title 3',
                  items: datingController.datings,
                ),
              ],
            ),
          );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<DatingModel> items}) {
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(item.title),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
