import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:speed_dating_front/common/models/api_response.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/models/profile_response_model.dart';

class DatingService {
  final String baseUrl = 'http://localhost:8080/api/v1';

  Future<List<DatingModel>> fetchDatings(int? lastId, int? limit) async {
    final int finalLastId = lastId ?? 0;
    final int finalLimit = limit ?? 10;

    final response = await http.get(
        Uri.parse('$baseUrl/datings?lastId=$finalLastId&limit=$finalLimit'));

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;

        ApiResponse<List<DatingModel>> apiResponse = ApiResponse.fromJson(
          jsonResponse,
          (data) => (data as List<dynamic>)
              .map((item) => DatingModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );

        return apiResponse.data;
      } catch (e) {
        print('Error: $e');
        return [];
      }
    } else {
      throw Exception('Failed to load datings');
    }
  }

  Future<ProfileResponseModel> fetchMyProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/user/profile/me'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;

        ApiResponse<ProfileResponseModel> apiResponse = ApiResponse.fromJson(
            jsonResponse,
            (json) =>
                ProfileResponseModel.fromJson(json as Map<String, dynamic>));

        return apiResponse.data;
      } catch (e) {
        print('Error: $e');
        throw e;
      }
    } else {
      throw Exception('Failed to load datings');
    }
  }
}
