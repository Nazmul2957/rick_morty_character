// lib/core/network/api_interceptor.dart

class ApiInterceptor {
  static Future<Map<String, String>> getHeaders() async {
    final headers = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    return headers;
  }
}
