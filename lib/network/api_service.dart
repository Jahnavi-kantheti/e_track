import 'package:dio/dio.dart';
import 'package:e_track/utils/global.dart';
import 'package:flutter/foundation.dart';

enum DioMethod { post, get, put, delete }

class ApiService {
  ApiService._singleton();

  static final ApiService instance = ApiService._singleton();

  String get baseUrl {
    if (kDebugMode) {
      return 'https://api.pragatiutrack.com/api/';
    }

    return 'production url';
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    String? contentType,
    dynamic formData,
  }) async {
    if (!await isInternetAvailable()) {
      throw Exception("Internet not available");
    }
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'X-Api-Key': 'FEA3E5D0QFCEBFD54F0A6A674ECAE3F8',
          },
        ),
      );
      kPrintLog(dio.options.baseUrl + endpoint);
      kPrintLog("Params: $param");
      kPrintLog("FormData: $formData");
      switch (method) {
        case DioMethod.post:
          Response res = await dio.post(
            endpoint,
            data: param ?? FormData.fromMap(formData),
          );
          kPrintLog(res);
          return res;
        case DioMethod.get:
          Response res = await dio.get(
            endpoint,
            queryParameters: param,
          );
          kPrintLog(res);
          return res;
        case DioMethod.put:
          Response res = await dio.put(
            endpoint,
            data: param ?? FormData.fromMap(formData),
          );
          kPrintLog(res);
          return res;
        case DioMethod.delete:
          Response res = await dio.delete(
            endpoint,
            data: param ?? FormData.fromMap(formData),
          );
          kPrintLog(res);
          return res;
        default:
          Response res = await dio.post(
            endpoint,
            data: param ?? FormData.fromMap(formData),
          );
          kPrintLog(res);
          return res;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
