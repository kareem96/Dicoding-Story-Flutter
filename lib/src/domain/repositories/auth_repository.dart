import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';

abstract class AuthRepository{
  Future<Either<Failure, Login>> login(LoginParams loginParams);
  Future<Either<Failure, Register>> register(RegisterParams registerParams);
  Future<Either<Failure, Stories>> stories(StoriesParams storiesParams);
  Future<Either<Failure, Upload>> upload(UploadParams uploadParams);
}