import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/datasources/datasources.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponse> login(LoginParams loginParams);

  Future<RegisterResponse> register(RegisterParams registerParams);

  Future<StoriesResponse> stories(StoriesParams storiesParams);

  Future<UploadResponse> upload(UploadParams uploadParams);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _client;

  AuthRemoteDatasourceImpl(this._client);

  @override
  Future<LoginResponse> login(LoginParams loginParams) async {
    try {
      final _response =
          await _client.postRequest(ListApi.login, data: loginParams.toJson());
      final _result = LoginResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return _result;
      } else {
        throw ServerException(_result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<StoriesResponse> stories(StoriesParams storiesParams) async {
    try {
      final _response = await _client.getRequest(ListApi.stories, queryParameters: storiesParams.toJson());
      final _result = StoriesResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return _result;
      } else {
        throw ServerException(_result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<RegisterResponse> register(RegisterParams registerParams) async {
    try {
      final _response = await _client.postRequest(ListApi.register,
          data: registerParams.toJson());
      final _result = RegisterResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return _result;
      } else {
        throw ServerException(_result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<UploadResponse> upload(UploadParams uploadParams) async {
    try {
      String fileName = uploadParams.photo!.path.split("/").last;
      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(uploadParams.photo!.path,
            filename: fileName),
        "description": uploadParams.description
      });
      final _response = await _client.postMultipart(
        ListApi.upload,
        formData,
      );
      final _result = UploadResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return _result;
      } else {
        throw ServerException(_result.message);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
