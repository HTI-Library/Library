class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String avatar;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? 'empty',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
