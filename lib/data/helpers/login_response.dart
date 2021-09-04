class LoginResponse {
  final bool success;
  final String authToken;

  LoginResponse({required this.success, required this.authToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      authToken: json['authToken'],
    );
  }
}
