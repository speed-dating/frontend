import 'dart:convert';
import 'package:speed_dating_front/common/models/api_response.dart';
import 'package:speed_dating_front/common/network/custom_http_client.dart';
import 'package:speed_dating_front/common/provider/token_provider.dart';
import 'package:speed_dating_front/home/models/dating.dart';
import 'package:speed_dating_front/home/models/profile_response_model.dart';

class DatingService {
  final String baseUrl = 'http://localhost:8080/api/v1';
  final CustomHttpClient _httpClient;

  DatingService(TokenProvider tokenProvider)
      : _httpClient = CustomHttpClient(
          tokenProvider: tokenProvider,
        ); // CustomHttpClient를 TokenProvider와 함께 초기화

  Future<List<DatingModel>> fetchDatings(int? lastId, int? limit) async {
    final int finalLastId = lastId ?? 0;
    final int finalLimit = limit ?? 10;

    final response = await _httpClient.get(
      Uri.parse('$baseUrl/datings?lastId=$finalLastId&limit=$finalLimit'),
    );

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
    final response = await _httpClient.get(
      Uri.parse('$baseUrl/user/profile/me'),
    );
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

  Future<void> createDating({
    required String title,
    required String description,
    required int maleCapacity,
    required int femaleCapacity,
    required DateTime startDate,
    required double price,
    String? imageUrl,
  }) async {
    final Uri url = Uri.parse('$baseUrl/dating/create');

    // Request body
    final Map<String, dynamic> body = {
      "title": title,
      "description": description,
      "maleCapacity": maleCapacity,
      "femaleCapacity": femaleCapacity,
      "startDate": startDate.toIso8601String(),
      "price": price.toInt(),
      "imageUrl": imageUrl,
    };

    try {
      final response = await _httpClient.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 201) {
        print("스개팅 생성 성공!");
      } else {
        print("스개팅 생성 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("API 요청 중 오류 발생: $e");
    }
  }
}
