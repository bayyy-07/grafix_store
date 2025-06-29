


class AppException implements Exception {
  final String? _message;  // Menggunakan tipe data String untuk _message
  final String _prefix;

  AppException([this._message, this._prefix = ""]);  // Default prefix jika tidak ada

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) 
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) 
      : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) 
      : super(message, "Unauthorised: ");
}

class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([String? message]) 
      : super(message, "Unprocessable Entity: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) 
      : super(message, "Invalid Input: ");
}
