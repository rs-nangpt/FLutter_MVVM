class LoginRequest {
  final String? email;
  final String? password;

  LoginRequest({this.email, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson(LoginRequest instance) => <String, dynamic>{
    'email': instance.email,
    'password': instance.password,
  };

}
