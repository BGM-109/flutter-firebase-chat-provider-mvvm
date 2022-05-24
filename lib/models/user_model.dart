class UserModel {
  final String name;
  final String profileImg;
  final String id;

  UserModel({required this.name, required this.profileImg, required this.id});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          profileImg: json['profileImg']! as String,
          id: json['id']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'profileImg': profileImg,
      'id': id,
    };
  }
}
