import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:speed_dating_front/dating/model/create_dating.model.dart';

final String datingDraftKey = "CREATE_DATING_DRAFT";

class CreateDatingStorage {
  static Future<void> saveDatingModel(CreateDatingModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(datingDraftKey, jsonEncode(model.toJson()));
  }

  static Future<CreateDatingModel?> loadDatingModel() async {
    final prefs = await SharedPreferences.getInstance();
    final String? modelString = prefs.getString(datingDraftKey);
    if (modelString != null) {
      final Map<String, dynamic> modelJson = jsonDecode(modelString);
      return CreateDatingModel.fromJson(modelJson);
    }
  }

  static Future<void> clearModel() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(datingDraftKey);
  }
}
