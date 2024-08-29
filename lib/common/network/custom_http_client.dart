import 'package:http/http.dart' as http;
import 'package:speed_dating_front/common/provider/token_provider.dart';

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final TokenProvider tokenProvider;

  CustomHttpClient({required this.tokenProvider});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final String? token = await tokenProvider.getToken();
    request.headers['Authorization'] = token ?? "";
    return _inner.send(request);
  }
}
