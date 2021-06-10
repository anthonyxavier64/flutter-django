class User {
  int userId;
  String email;
  String password;
  String profilePicId;

  User({
    this.userId = 0,
    this.email = '',
    this.password = '',
    this.profilePicId = ''
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String profilePicId;
    json['profilePicId'] == null ? profilePicId = '' : profilePicId = json['profilePicId'];
    print(json['id']);
    return User(
      userId: json['id'],
      email: json['email'],
      password: json['password'],
      profilePicId: profilePicId
    );
  }
}