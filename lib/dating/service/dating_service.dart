import 'dart:convert';
import 'package:speed_dating_front/common/models/api_response.dart';
import 'package:speed_dating_front/common/network/custom_http_client.dart';
import 'package:speed_dating_front/common/provider/token_provider.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/models/profile_response_model.dart';

class DatingService {
  final String baseUrl = 'http://localhost:8080/api/v1';
  final CustomHttpClient _httpClient;
  final TokenProvider tokenProvider;

  DatingService({required this.tokenProvider})
      : _httpClient = CustomHttpClient(tokenProvider: tokenProvider);

  Future<List<DatingModel>> fetchDatings({int? lastId, int? limit}) async {
    final int finalLastId = lastId ?? 0;
    final int finalLimit = limit ?? 10;

    final response = await _httpClient.get(
      Uri.parse('$baseUrl/datings?lastId=$finalLastId&limit=$finalLimit'),
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final ApiResponse<List<DatingModel>> apiResponse = ApiResponse.fromJson(
          jsonResponse,
          (data) => (data as List<dynamic>)
              .map((item) => DatingModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
        return apiResponse.data;
      } catch (e) {
        print('Error parsing datigs: $e');
        return [];
      }
    } else {
      throw Exception(
          'Failed to load datings, status code: ${response.statusCode}');
    }
  }

  // Fetch profile of the current user
  Future<ProfileResponseModel> fetchMyProfile() async {
    final response = await _httpClient.get(
      Uri.parse('$baseUrl/user/profile/me'),
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final ApiResponse<ProfileResponseModel> apiResponse =
            ApiResponse.fromJson(
          jsonResponse,
          (json) => ProfileResponseModel.fromJson(json as Map<String, dynamic>),
        );
        return apiResponse.data;
      } catch (e) {
        print('Error parsing profile response: $e');
        throw e;
      }
    } else {
      throw Exception(
          'Failed to load profile, status code: ${response.statusCode}');
    }
  }

  // Create a new dating event
  Future<void> createDating({
    required String title,
    required String description,
    required int maleCapacity,
    required int femaleCapacity,
    required DateTime startDate,
    required double price,
    required List<String> imagePaths,
    required List<String> tags,
  }) async {
    final Uri url = Uri.parse('$baseUrl/dating/create');

    // Prepare the request body
    final Map<String, dynamic> body = {
      "title": title,
      "description": description,
      "maleCapacity": maleCapacity,
      "femaleCapacity": femaleCapacity,
      "startDate": startDate.toIso8601String(),
      "price": price.toInt(),
      "imagePaths": imagePaths,
      "tags": tags,
    };

    try {
      final response = await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        print("Successfully created the dating event!");
      } else {
        print(
            "Failed to create the dating event: Status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred while creating the dating event: $e");
      throw Exception('Failed to create dating event');
    }
  }
}
