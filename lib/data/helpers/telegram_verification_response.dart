class TelegramVerificationResponse {
  final bool success;
  final String msg;
  final String token;

  TelegramVerificationResponse({required this.success, required this.msg,required this.token});

  factory TelegramVerificationResponse.fromJson(Map<String, dynamic> json) {
    return TelegramVerificationResponse(
      success: json['success'],
      msg: json['msg'],
      token:json['token']
    );
  }
}
