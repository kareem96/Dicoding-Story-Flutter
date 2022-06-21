import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final GetStories _getStories;
  int page = 1;

  StoriesCubit(this._getStories) : super(const StoriesState());

  Future<void> fetchStories(StoriesParams storiesParams) async {
    await _fetchData(storiesParams);
  }

  Future<void> refreshStories(StoriesParams storiesParams) async {
    await _fetchData(storiesParams);
  }

  Future<void> fetchStoriesAnother(StoriesParams storiesParams)async{

  }

  Future<void> _fetchData(StoriesParams storiesParams) async {
    if (storiesParams.page == page) {
      emit(state.copyWith(status: StoriesStatus.loading));
    }

    /*emit(state.copyWith(status: StoriesStatus.loading));*/
    final _data = await _getStories.call(storiesParams);

    _data.fold((l) {
      if (l is ServerFailure) {
        emit(state.copyWith(status: StoriesStatus.failure, message: l.message));
      } else if (l is NoDataFailure) {
        emit(state.copyWith(status: StoriesStatus.empty));
      }
    }, (r) {
      return emit(
        state.copyWith(status: StoriesStatus.success, stories: r),
      );
    });
  }
}
