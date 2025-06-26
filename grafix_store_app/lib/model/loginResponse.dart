class LoginResponse {
  final String token;
  final int userId;
  final String auth_key;

  LoginResponse({required this.token, required this.userId, required this.auth_key,});

  
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['data']['token'],
      userId: json['data']['user']['id'],
      auth_key: json['auth_key'],
    );
  }
}
