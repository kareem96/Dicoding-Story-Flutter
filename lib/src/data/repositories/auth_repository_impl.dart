import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/data/datasources/datasources.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/domain/entities/auth/login.dart';
import 'package:dicoding_story_flutter/src/domain/usecase/auth/post_login.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, Login>> login(LoginParams loginParams) async{
    try{
      final _response = await authRemoteDatasource.login(loginParams);
      return Right(_response.toEntity());
    }on ServerException catch (e){
      return Left(ServerFailure(e.message));
    }
  }

}