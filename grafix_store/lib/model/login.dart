class Login {
  int? code;
  bool? status;
  String? token;
  int? userID; 
  String? userEmail;
  String? auth_key;

  // Constructor
  Login({this.code, this.status, this.token, this.userID, this.userEmail, this.auth_key,});

  factory Login.fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] != null && json['data']['user'] != null) {
        // Memastikan status adalah true 
        if (json['status'] == true) {
          return Login(
            code: _toInt(json['code']),
            status: json['status'] as bool?,
            token: json['data']['token'] as String?,
            userID: _toInt(json['data']['user']['id']),
            userEmail: json['data']['user']['email'] as String?,
            auth_key: json['auth_key'] as String?, // Ambil dari JSON
          );
        } else {
          throw FormatException("Login failed. Status is false.");
        }
      } else {
        throw FormatException("Invalid structure: Missing 'data' or 'user' in response.");
      }
    } catch (e) {
      throw FormatException("Error parsing Login data: $e");
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'auth_key': auth_key,
      'data': {
        'token': token,
        'user': {
          'id': userID,
          'email': userEmail,
        },
      },
    };
  }

  // Helper Method untuk Konversi ke Int
  static int? _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null; // Jika bukan String atau int, kembalikan null
  }
}
