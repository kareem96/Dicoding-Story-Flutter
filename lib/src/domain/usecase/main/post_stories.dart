import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';

class PostStories extends UseCase<Upload, UploadParams>{
  final AuthRepository _repo;

  PostStories(this._repo);

  @override
  Future<Either<Failure, Upload>> call(UploadParams params) => _repo.upload(params);

}

class UploadParams {
  final String description;
  final File? photo;

  UploadParams({
    this.description = "",
    this.photo,
  });

  Map<String, dynamic> toJson() =>{
    "description" : description,
    "photo" : photo,
  };
}