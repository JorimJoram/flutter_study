import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>?> fetchData() async {
    final url = Uri.parse(
      "http://192.168.0.229:12500/api/v1/review/85945142?page=0&size=10&sortedBy=desc",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        log(response.body);
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        debugPrint("Error Occured: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception Occured: $e");
      return null;
    }
  }
}
