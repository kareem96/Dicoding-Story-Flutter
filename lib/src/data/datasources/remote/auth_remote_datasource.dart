import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/datasources/datasources.dart';
import 'package:dicoding_story_flutter/src/domain/usecase/auth/auth.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponse> login(LoginParams loginParams);
  Future<StoriesResponse> stories(StoriesParams storiesParams);
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
        throw ServerException("_result.error");
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<StoriesResponse> stories(StoriesParams storiesParams) async{
    try{
      final _response = await _client.getRequest(ListApi.stories,);
      final _result = StoriesResponse.fromJson(_response.data);
      if(_response.statusCode == 200){
        return _result;
      }else{
        throw ServerException(_result.message);
      }
    }on ServerException catch (e){
      throw ServerException(e.message);
    }
  }

}
