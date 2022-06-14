import 'package:dicoding_story_flutter/src/core/core.dart';
import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final PostStories _postStories;

  UploadCubit(this._postStories) : super(const UploadState());

  Future<void> upload(UploadParams uploadParams) async {
    emit(state.copyWith(status: UploadStatus.loading));
    final _data = await _postStories.call(uploadParams);

    _data.fold((l) {
      if (l is ServerFailure) {
        emit(
          state.copyWith(status: UploadStatus.failure, message: l.message),
        );
      }
    }, (r) {
      emit(state.copyWith(status: UploadStatus.success, upload: r));
    });
  }
}
