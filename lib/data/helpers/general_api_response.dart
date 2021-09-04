class ApiResponse {
  final bool success;
  final String msg;

  ApiResponse({required this.success, required this.msg});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      msg: json['msg'],
    );
  }
}
