import 'package:reminder_app/core/api/end_points.dart';

class ErrorModel {
  final int status;
  final String errorMessage;
  final String msg;
  final String message;

  ErrorModel({
    required this.status,
    required this.errorMessage,
    required this.msg,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    String parseError(dynamic error) {
      if (error is String) {
        return error;
      } else if (error is Map<String, dynamic>) {
        return error['message'] ??
            'Unknown error'; // or any key that contains the error message
      }
      return 'Unknown error';
    }

    return ErrorModel(
      status: int.tryParse(jsonData[ApiKey.status]?.toString() ?? '0') ?? 0,
      errorMessage: parseError(jsonData[ApiKey.error]),
      msg: parseError(jsonData[ApiKey.msg]),
      message: parseError(jsonData[ApiKey.message]),
    );
  }
}
