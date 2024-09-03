import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_app/utils/constants.dart';
// import 'dart:convert';

class ApiServices {
  static Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(Constants.baseUrl + url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${body['access_token'] ?? ''}",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(utf8.decode(response.bodyBytes)),
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(utf8.decode(response.bodyBytes)),
      };
    }
  }

  static Future<Map<String, dynamic>> get(String url) async {
    final response = await http.get(Uri.parse(Constants.baseUrl + url), headers: {
      "Content-Type": "application/json",
    });

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

  static Future<Map<String, dynamic>> put(String url, String token, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('${Constants.baseUrl}$url/${body['recipe_id']}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(utf8.decode(response.bodyBytes)),
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(utf8.decode(response.bodyBytes)),
      };
    }
  }

  static Future<Map<String, dynamic>> getCustomer(String id, String token) async {
    print(id + token);
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}${Constants.customerProfileRoute}/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
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
}
