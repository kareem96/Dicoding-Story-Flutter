part of 'upload_cubit.dart';

enum UploadStatus { loading, success, failure }

extension UploadStatusX on UploadStatus {
  bool get isLoading => this == UploadStatus.loading;

  bool get isFailure => this == UploadStatus.failure;

  bool get isSuccess => this == UploadStatus.success;
}

class UploadState extends Equatable {
  final UploadStatus status;
  final Upload? upload;
  final String? message;

  const UploadState(
      {this.status = UploadStatus.loading, this.upload, this.message});

  UploadState copyWith({
    UploadStatus? status,
    Upload? upload,
    String? message,
  }) {
    return UploadState(
      status: status ?? this.status,
      upload: upload ?? this.upload,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    upload,
    message
  ];
}
