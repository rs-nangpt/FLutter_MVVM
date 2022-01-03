class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['artistName'] as int?,
      firstName: json['collectionName'] as String?,
      email: json['trackName'] as String?,
      lastName: json['artworkUrl100'] as String?,
      avatar: json['previewUrl'] as String?,
    );
  }
}
