import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({
        "Authorization": "Bearer $token",
      });
    }

    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      debugPrint("success");
      return jsonDecode(response.body);
    } else {
      debugPrint(response.body);
      throw Exception(response.body);
    }
  }

  Future<dynamic> postWithEmailAndPassword(
      {required String url, dynamic body, String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({
        "Authorization": "Bearer $token",
      });
    }

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future<dynamic> put(
      {required String url, dynamic body, String? token}) async {
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    if (token != null) {
      headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    if (kDebugMode) {
      print("url =$url body=$body token=$token");
    }
    http.Response response = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers,
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load data status code: ${response.statusCode}');
    }
  }

  Future<dynamic> patch({
    required String url,
    dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    // Ensure that the body is correctly encoded to JSON
    final encodedBody = jsonEncode(body);

    // if body == null  not send
    http.Response response = await http.patch(
      Uri.parse(url),
      body: body == null
          ? null
          : encodedBody, // Correctly encode the body to JSON
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      debugPrint("success");
      return jsonDecode(response.body); // Return the decoded JSON response
    } else {
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      throw Exception(response.body);
    }
  }

  Future<dynamic> delete({
    required String url,
    String? token,
  }) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    // if body == null  not send
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      debugPrint("success");
      return jsonDecode(response.body); // Return the decoded JSON response
    } else {
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());

      throw Exception(response.body);
    }
  }
}
