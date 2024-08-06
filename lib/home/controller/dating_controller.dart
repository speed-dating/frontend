import 'package:flutter/material.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/models/profile_response_model.dart';
import 'package:speed_dating_front/home/service/dating_service.dart';

class DatingController with ChangeNotifier {
  DatingService _service = DatingService();
  List<DatingModel> _datings = [];
  bool _isLoading = false;

  List<DatingModel> get datings => _datings;
  bool get isLoading => _isLoading;

  Future<void> fetchDatings(int? lastId, int? limit) async {
    lastId = lastId ?? 0;
    limit = limit ?? 10;

    _isLoading = true;
    notifyListeners();

    try {
      print("here");
      _datings = await _service.fetchDatings(lastId, limit);
      print('datings : ${datings}');
    } catch (e) {
      // todo : handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class ProfileController with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage = null;
  final DatingService service;
  ProfileResponseModel? profile;

  ProfileController({required this.service});

  Future<void> fetchMyProfile() async {
    isLoading = true;
    notifyListeners();

    try {
      print("here");
      profile = await this.service.fetchMyProfile();
      print(profile);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
