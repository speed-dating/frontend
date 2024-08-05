import 'package:banner_carousel/banner_carousel.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String avatarUrl = 'https://example.com/avatar.jpg';
  final String nickname = 'John Doe';
  final String introduction = 'Flutter Developer at XYZ Company';
  final List<String> interests = [
    'Flutter',
    'Dart',
    'Mobile Development',
    'Flutter',
    'Dart',
    'Mobile Development',
    'Flutter',
    'Dart',
    'Mobile Development'
  ];

  static const List<String> sampleImages = [
    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1502764613149-7f1d229e2302?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDV8fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDZ8fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1511367461989-f85a21fda167?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDd8fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDh8fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDl8fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1517841905240-472988babdf9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDEwfG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1527980965255-d3b416303d12?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDExfGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDEyfG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDEzfGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1517705008127-8c9187dda3e7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE0fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1526045612212-70caf35c14df?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE1fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1531123897727-8f129e1688ce?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE2fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE3fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1539914287624-4fbc5a7bcd8d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE4fG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1541698444083-023c97d3f4b6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDIwfG1hbGV8ZW58MHx8fHwxNjE2NDA2NzEw&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1544653516-57c972f063e9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDIxfGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
    "https://images.unsplash.com/photo-1541635680542-168610c67ef6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE5fGZlbWFsZXxlbnwwfHx8fDE2MTY0MDY3MTg&ixlib=rb-1.2.1&q=80&w=400",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                SizedBox(width: 16),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nickname,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      introduction,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Interests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: interests
                  .map((interest) => Chip(
                        label: Text(interest),
                      ))
                  .toList(),
            ),
            SizedBox(height: 24),
            Text(
              'Gallery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(height: 33),
            FanCarouselImageSlider.sliderType1(
              imagesLink: sampleImages,
              isAssets: false,
              autoPlay: false,
              sliderHeight: 400,
              showIndicator: false,
              turns: 300,
              showArrowNav: true,
              isClickable: false,
            ),
          ],
        ),
      ),
    );
  }
}
