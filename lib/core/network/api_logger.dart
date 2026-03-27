// lib/core/network/api_logger.dart

import 'dart:developer';

class ApiLogger {

  static void logRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) {
    log("----- API REQUEST -----");
    log("METHOD: $method");
    log("URL: $url");

    if (headers != null) {
      log("HEADERS: $headers");
    }

    if (body != null) {
      log("BODY: $body");
    }

    log("-----------------------");
  }

  static void logResponse({
    required int statusCode,
    required String url,
    dynamic body,
  }) {
    log("----- API RESPONSE -----");
    log("URL: $url");
    log("STATUS CODE: $statusCode");
    log("BODY: $body");
    log("------------------------");
  }

  static void logError({
    required String url,
    required dynamic error,
  }) {
    log("----- API ERROR -----");
    log("URL: $url");
    log("ERROR: $error");
    log("---------------------");
  }
}