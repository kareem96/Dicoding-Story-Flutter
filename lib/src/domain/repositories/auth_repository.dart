import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/domain/entities/auth/login.dart';
import 'package:dicoding_story_flutter/src/domain/entities/auth/stories.dart';

abstract class AuthRepository{
  Future<Either<Failure, Login>> login(LoginParams loginParams);
  Future<Either<Failure, Stories>> stories(StoriesParams storiesParams);
}