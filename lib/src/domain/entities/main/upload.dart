import 'package:equatable/equatable.dart';

class Upload extends Equatable{
  final String? message;
  final double? error;

  const Upload(this.message, this.error);

  @override
  List<Object?> get props => [
    message,
    error,
  ];

}