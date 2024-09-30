import 'package:flutter/material.dart';
import 'package:speed_dating_front/dating/service/dating_service.dart';
import 'package:speed_dating_front/dating/model/create_dating.model.dart';
import 'package:speed_dating_front/home/models/dating.dart';

class DatingController with ChangeNotifier {
  final DatingService _datingService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DatingModel> _datings = [];
  List<DatingModel> get datings => _datings;

  DatingController({required DatingService service}) : _datingService = service;

  // Fetch Dating Events
  Future<void> fetchDatings({int? lastId, int? limit}) async {
    _isLoading = true;
    notifyListeners();
    try {
      _datings =
          await _datingService.fetchDatings(lastId: lastId, limit: limit);
    } catch (e) {
      print('Error while fetching datings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a New Dating Event
  Future<void> createDating(CreateDatingModel model) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _datingService.createDating(
        title: model.title!,
        description: model.description!,
        maleCapacity: model.maleCapacity!,
        femaleCapacity: model.femaleCapacity!,
        startDate: DateTime.now(),
        price: model.price!,
        imagePaths: model.imagePaths!,
        tags: model.tags!,
      );
      // After creation, fetch updated list
      await fetchDatings();
    } catch (e) {
      print('Error while creating dating: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
