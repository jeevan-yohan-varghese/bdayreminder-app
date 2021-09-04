class BdayUser {
  String name;
  String email;
  String profilePic;
  String telegram;
  bool isTelegram;
  bool isPush;

  BdayUser(
      {required this.name,
      required this.email,
      required this.profilePic,
      required this.telegram,
      required this.isTelegram,
      required this.isPush});

  factory BdayUser.fromJson(Map<String, dynamic> json) {
    return BdayUser(
        name: json['name'],
        email: json['email'],
        profilePic: json['profilePic'],
        telegram: json['telegram'],
        isTelegram: json['isTelegram'],
        isPush: json['isPush']);
  }
}
