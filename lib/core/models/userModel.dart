class UserModelFirebase {
  String? name;
  String? email;
  String? phone;
  String? avatar;

  UserModelFirebase({
    this.name,
    this.email,
    this.phone,
    this.avatar,
  });

  UserModelFirebase.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'avatar': avatar,
  };
}