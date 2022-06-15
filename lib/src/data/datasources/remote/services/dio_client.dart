import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/data/datasources/datasources.dart';
import 'package:dicoding_story_flutter/src/di/di.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:path/path.dart';


class DioClient {
  /*String baseUrl = "https://reqres.in";*/
  String baseUrl = "https://story-api.dicoding.dev";

  String? _auth;
  bool _isUnitTest = false;
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;
    try {
      _auth = sl<PrefManager>().token;
    } catch (_) {}
    _dio = _createDio();
    if (!isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (_isUnitTest) {
      return _dio;
    } else {
      try {
        _auth = sl<PrefManager>().token;
      } catch (_) {}
      final _dio = _createDio();
      if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
      return _dio;
    }
  }

  Dio _createDio() =>
      Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            if (_auth != null) ...{
              "Authorization": "Bearer $_auth",
            }
          },
          receiveTimeout: 5000,
          connectTimeout: 5000,
          validateStatus: (int? status) {
            return status! > 0;
          }));

  Future<Response> getRequest(String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(url, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(String url,
      {Map<String, dynamic>? data,}) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postMultipart(String url, FormData data,) async {
    try {
      /*final uploadParam = UploadParams();
      var formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(uploadParam.photo!.path)
      });*/
      /*var formData = FormData.fromMap(data!);*/
      return await dio.post(url, data: data, options: Options(contentType: "multipart/form-data"));
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }


}
