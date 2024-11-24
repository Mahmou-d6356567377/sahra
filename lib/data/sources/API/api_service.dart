import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio;
  ApiService._(this._dio);

  static final ApiService _instance = ApiService._(Dio());
  factory ApiService() {
    return _instance;
  }

  Future<Map<String, dynamic>> get(
      {required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    var response = await _dio.get(
      url,
      options: Options(headers: headers),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String url,
    @required String? token,
    required dynamic body,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    // Set 'Content-Type' only if body is not FormData
    if (body is! FormData) {
      headers['content-type'] = 'application/json';
    }

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    var response = await _dio.post(
      url,
      data: body,
      options: Options(
        headers: headers,
        validateStatus: (status) {
          return status! < 500; // Accept status codes under 500
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> del(
      {required String url, @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    var response = await _dio.delete(
      url,
      options: Options(headers: headers),
    );
    return response.data;
  }
}
