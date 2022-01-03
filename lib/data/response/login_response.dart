class LoginResponse {
  final String? error;
  final String? token;

  LoginResponse({this.error, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      error: json['error'] as String?,
      token: json['token'] as String?,
    );
  }
}
