class UserModel {
  String userId;
  String email;
  String username;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
    };
  }
}
