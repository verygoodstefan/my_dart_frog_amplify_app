import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

/// Extension on [Request] to map the request body to a `Map<String, dynamic>`
extension RequestMapper on Request {
  /// Returns the request body as a `Map<String, dynamic>`
  Future<Map<String, dynamic>> map() async =>
      Map<String, dynamic>.from(jsonDecode(await body()) as Map);
}
