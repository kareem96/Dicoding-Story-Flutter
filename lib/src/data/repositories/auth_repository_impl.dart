import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/datasources/datasources.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async {
    try {
      final _response = await authRemoteDatasource.login(loginParams);
      return Right(_response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Stories>> stories(StoriesParams storiesParams) async {
    try {
      final _response = await authRemoteDatasource.stories(storiesParams);
      if (_response.data?.isEmpty ?? true) {
        return Left(NoDataFailure());
      }
      return Right(_response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Register>> register(
      RegisterParams registerParams) async {
    try {
      final _response = await authRemoteDatasource.register(registerParams);
      return Right(_response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
