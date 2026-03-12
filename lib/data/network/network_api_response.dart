import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../app_exception.dart';
import 'base_api_response.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
      await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException("");
    } on RequestTimeOut {
      throw RequestTimeOut("");
    }
    return responseJson;
  }

  Future<dynamic> postApi(var data, String url,[var token]) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic? responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
          // Add any other headers you might need
        },
      ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException("Internet exception ");
    } on RequestTimeOut {
      throw RequestTimeOut("server request exception");
    }
    if (kDebugMode) {
      print(" response json ${responseJson}");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print("HTTP Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
      // Log the server validation errors for debugging
        final responseBody = jsonDecode(response.body);
        if (kDebugMode) {
          print("Validation Errors: ${responseBody['errors']}");
        }
        throw Exception("Validation Error: ${responseBody['errors']}");
      case 401:
      case 403:
        throw Exception("Unauthorized Access: ${response.body}");
      case 404:
        throw Exception("Invalid URL or Endpoint Not Found: ${response.body}");
      case 500:
      default:
        throw Exception("Server Error: ${response.statusCode}, ${response.body}");
    }
  }

}
