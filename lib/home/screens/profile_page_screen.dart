import 'package:banner_carousel/banner_carousel.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/home/controller/dating_controller.dart';
import 'package:speed_dating_front/home/service/dating_service.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ProfileController(service: DatingService())..fetchMyProfile(),
      child: ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final galleryImages =
        profileController.profile!.galleries.map((e) => e.imageUrl).toList();

    return profileController.isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            profileController.profile!.profileImageUrl),
                      ),
                      SizedBox(width: 16),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileController.profile!.nickname,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            profileController.profile!.introduce,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
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
                    children: profileController.profile!.tags
                        .map((tag) => Chip(
                              label: Text(tag.content),
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
                  galleryImages.length > 0
                      ? FanCarouselImageSlider.sliderType1(
                          imagesLink: profileController.profile!.galleries
                              .map((e) => e.imageUrl)
                              .toList(),
                          isAssets: false,
                          autoPlay: false,
                          sliderHeight: 400,
                          showIndicator: false,
                          turns: 300,
                          showArrowNav: true,
                          isClickable: false,
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }
}
