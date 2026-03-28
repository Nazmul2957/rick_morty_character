// lib/core/network/api_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../errors/exception.dart';
import '../utils/snackbar_service.dart';
import 'api_logger.dart';
import 'api_interceptor.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    final baseUri = Uri.parse(AppConstants.baseUrl);

    final uri = baseUri.replace(
      path: "${baseUri.path}$endpoint",
      queryParameters: queryParameters,
    );

    final headers = await ApiInterceptor.getHeaders();

    ApiLogger.logRequest(method: "GET", url: uri.toString(), headers: headers);

    try {
      final response = await client.get(uri, headers: headers);

      ApiLogger.logResponse(
        url: uri.toString(),
        statusCode: response.statusCode,
        body: response.body,
      );

      return _handleResponse(response);
    } catch (e) {
      ApiLogger.logError(url: uri.toString(), error: e);
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Optionally show success messages from API
        try {
          final data = jsonDecode(response.body);
          if (data is Map<String, dynamic> && data.containsKey("message")) {
            SnackbarService.instance.showSuccess(data["message"]);
          }
        } catch (_) {}
        return jsonDecode(response.body);

      case 400:
        SnackbarService.instance.showError("Bad Request");
        throw ServerException(message: "Bad Request");

      case 401:
        SnackbarService.instance.showError("Unauthorized");
        throw UnauthorizedException(message: "Unauthorized");

      case 404:
        SnackbarService.instance.showError("You've reached the end of the list");
        throw NotFoundException(message: "No more characters found");

      case 500:
        SnackbarService.instance.showError("Server Error");
        throw ServerException(message: "Server Error");

      default:
        SnackbarService.instance.showError("Unexpected Error");
        throw ServerException(message: "Unexpected Error");
    }
  }
}
