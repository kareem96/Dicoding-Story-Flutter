import 'package:dartz/dartz.dart';
import 'package:dicoding_story_flutter/src/core/core.dart';

import '../../domain.dart';

class GetStories extends UseCase<Stories, StoriesParams> {
  final AuthRepository _repo;

  GetStories(this._repo);

  @override
  Future<Either<Failure, Stories>> call(StoriesParams params) =>
      _repo.stories(params);
}

class StoriesParams {
  int page;

  StoriesParams({
    this.page = 1,
  });

  Map<String, dynamic> toJson() => {
        "page": page,
      };
}
