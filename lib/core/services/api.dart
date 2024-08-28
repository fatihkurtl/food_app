import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/utils/constants.dart';
// import 'dart:convert';

class ApiServices {
  static Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    // print('url' + url);
    // print('register data' + body.toString());
    final response = await http.post(
      Uri.parse(Constants.baseUrl + url),
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(Constants.baseUrl + url), headers: {
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      // print('get main' + response.body);
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> put(String url, String token, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse(Constants.baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    }
  }

  static Future<Map<String, dynamic>> getUser(String url, String token) async {
    final response = await http.get(
      Uri.parse(Constants.baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    User user = User.fromJson(jsonResponse);

    if (response.statusCode == 200) {
      return {
        "statusCode": response.statusCode,
        "body": user,
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": response.body,
      };
    }
  }
}
