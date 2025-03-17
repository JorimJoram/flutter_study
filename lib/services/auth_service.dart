import "dart:convert";

import "package:flutter/widgets.dart";
import "package:http/http.dart" as http;

class AuthService {
  static Future<String?> authentication(String phone, String password) async {
    final url = Uri.parse("http://192.168.0.229:12500/api/v1/auth");

    try {
      debugPrint("data ${{'phone': phone, 'password': password}}");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['accessToken'];
      } else {
        debugPrint('Authentication Failed');
        return null;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      return null;
    }
  }
}
